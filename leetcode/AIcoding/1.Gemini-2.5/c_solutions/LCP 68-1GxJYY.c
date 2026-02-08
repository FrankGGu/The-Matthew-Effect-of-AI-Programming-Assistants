#include <stdlib.h>
#include <limits.h> // For LLONG_MAX

long long ll_min(long long a, long long b) {
    return (a < b) ? a : b;
}

typedef struct {
    int* data;
    int size;
    int capacity;
} IntVector;

void init_vector(IntVector* vec) {
    vec->size = 0;
    vec->capacity = 4; // Initial capacity
    vec->data = (int*)malloc(vec->capacity * sizeof(int));
    if (vec->data == NULL) {
        exit(EXIT_FAILURE); // Handle allocation failure
    }
}

void push_back(IntVector* vec, int val) {
    if (vec->size == vec->capacity) {
        vec->capacity *= 2;
        vec->data = (int*)realloc(vec->data, vec->capacity * sizeof(int));
        if (vec->data == NULL) {
            exit(EXIT_FAILURE); // Handle reallocation failure
        }
    }
    vec->data[vec->size++] = val;
}

void free_vector(IntVector* vec) {
    free(vec->data);
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

typedef struct SegmentTreeNode {
    long long min_val;
} SegmentTreeNode;

SegmentTreeNode* tree;
int N_seg_tree; // Size of the array for which segment tree is built
long long INF_SEG_TREE;

void build(int node, int start, int end) {
    if (start == end) {
        tree[node].min_val = INF_SEG_TREE;
    } else {
        int mid = start + (end - start) / 2; // Prevent overflow
        build(2 * node, start, mid);
        build(2 * node + 1, mid + 1, end);
        tree[node].min_val = INF_SEG_TREE;
    }
}

void update(int node, int start, int end, int idx, long long val) {
    if (start == end) {
        tree[node].min_val = val;
    } else {
        int mid = start + (end - start) / 2;
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        tree[node].min_val = ll_min(tree[2 * node].min_val, tree[2 * node + 1].min_val);
    }
}

long long query(int node, int start, int end, int l, int r) {
    if (r < start || end < l || l > r) { // Added l > r check for invalid ranges
        return INF_SEG_TREE;
    }
    if (l <= start && end <= r) {
        return tree[node].min_val;
    }
    int mid = start + (end - start) / 2;
    long long p1 = query(2 * node, start, mid, l, r);
    long long p2 = query(2 * node + 1, mid + 1, end, l, r);
    return ll_min(p1, p2);
}

long long maximumSumOfBeautifulSubarrays(int* nums, int numsSize, long long k) {
    N_seg_tree = numsSize;
    INF_SEG_TREE = LLONG_MAX; // Use LLONG_MAX for infinity

    if (numsSize == 0) {
        return -1LL;
    }

    // 1. Precompute prev_greater and next_smaller
    int* prev_greater = (int*)malloc(numsSize * sizeof(int));
    int* next_smaller = (int*)malloc(numsSize * sizeof(int));
    int* stack = (int*)malloc(numsSize * sizeof(int));

    if (!prev_greater || !next_smaller || !stack) {
        exit(EXIT_FAILURE); // Handle allocation failure
    }

    int stack_top = -1;

    // Calculate next_smaller (index of first element to the right strictly smaller than current)
    // For nums[l] to be minimum in nums[l..r], all nums[x] for x in (l, r] must be >= nums[l].
    // This implies next_smaller[l] must be > r.
    for (int i = numsSize - 1; i >= 0; --i) {
        while (stack_top != -1 && nums[stack[stack_top]] >= nums[i]) {
            stack_top--;
        }
        next_smaller[i] = (stack_top == -1) ? numsSize : stack[stack_top];
        stack[++stack_top] = i;
    }

    // Clear stack for next use
    stack_top = -1;

    // Calculate prev_greater (index of first element to the left strictly greater than current)
    // For nums[r] to be maximum in nums[l..r], all nums[x] for x in [l, r) must be <= nums[r].
    // This implies prev_greater[r] must be < l.
    for (int i = 0; i < numsSize; ++i) {
        while (stack_top != -1 && nums[stack[stack_top]] <= nums[i]) {
            stack_top--;
        }
        prev_greater[i] = (stack_top == -1) ? -1 : stack[stack_top];
        stack[++stack_top] = i;
    }

    free(stack); // Stack is no longer needed

    // 2. Precompute prefix_sum
    long long* prefix_sum = (long long*)malloc((numsSize + 1) * sizeof(long long));
    if (!prefix_sum) {
        exit(EXIT_FAILURE); // Handle allocation failure
    }
    prefix_sum[0] = 0;
    for (int i = 0; i < numsSize; ++i) {
        prefix_sum[i + 1] = prefix_sum[i] + nums[i];
    }

    long long max_beautiful_sum = -1LL;

    // 3. Initialize segment tree
    tree = (SegmentTreeNode*)malloc(4 * numsSize * sizeof(SegmentTreeNode));
    if (!tree) {
        exit(EXIT_FAILURE); // Handle allocation failure
    }
    build(1, 0, numsSize - 1);

    // 4. Create removals list: stores indices 'l' that become invalid when 'r' reaches next_smaller[l]
    IntVector* removals = (IntVector*)malloc((numsSize + 1) * sizeof(IntVector));
    if (!removals) {
        exit(EXIT_FAILURE); // Handle allocation failure
    }
    for (int i = 0; i <= numsSize; ++i) {
        init_vector(&removals[i]);
    }
    for (int i = 0; i < numsSize; ++i) {
        push_back(&removals[next_smaller[i]], i);
    }

    // 5. Iterate r from 0 to numsSize-1
    for (int r = 0; r < numsSize; ++r) {
        // Remove 'l's whose next_smaller is 'r'.
        // This means for these 'l's, nums[l] is no longer the minimum in [l..r].
        // Their prefix_sum values are set to INF_SEG_TREE in the segment tree.
        for (int i = 0; i < removals[r].size; ++i) {
            int l_to_remove = removals[r].data[i];
            update(1, 0, numsSize - 1, l_to_remove, INF_SEG_TREE);
        }

        // Add 'r' to the segment tree.
        // This makes `l=r` a candidate for `l`. We store prefix_sum[r] for index r.
        update(1, 0, numsSize - 1, r, prefix_sum[r]);

        // Determine query range for 'l': [prev_greater[r]+1, r]
        // This range ensures that nums[r] is the maximum in nums[l..r].
        int L = prev_greater[r] + 1;
        int R = r;

        if (L <= R) {
            long long min_val_prefix_sum_l = query(1, 0, numsSize - 1, L, R);
            if (min_val_prefix_sum_l != INF_SEG_TREE) {
                long long current_sum = prefix_sum[r + 1] - min_val_prefix_sum_l;
                if (current_sum >= k) {
                    if (max_beautiful_sum == -1LL || current_sum > max_beautiful_sum) {
                        max_beautiful_sum = current_sum;
                    }
                }
            }
        }
    }

    // Free allocated memory
    free(prev_greater);
    free(next_smaller);
    free(prefix_sum);
    free(tree);
    for (int i = 0; i <= numsSize; ++i) {
        free_vector(&removals[i]);
    }
    free(removals);

    return max_beautiful_sum;
}