#include <stdlib.h> // For malloc, realloc, free, qsort

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int compareLongLong(const void *a, const void *b) {
    long long valA = *(const long long *)a;
    long long valB = *(const long long *)b;
    if (valA < valB) {
        return 1; // valA comes after valB (descending)
    } else if (valA > valB) {
        return -1; // valA comes before valB (descending)
    } else {
        return 0;
    }
}

long long kthLargestLevelSum(struct TreeNode* root, int k) {
    // According to constraints, root will not be NULL and there will be at least one level.
    // The number of levels in the tree is in the range [1, 10^5].
    // The number of nodes in the tree is in the range [1, 10^5].

    // Use a fixed-size array for the queue, large enough for max nodes (10^5)
    struct TreeNode** queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 100005);
    int head = 0;
    int tail = 0; // tail points to the next available slot

    // Enqueue the root
    queue[tail++] = root;

    // Use a fixed-size array for level sums, large enough for max levels (10^5)
    long long* level_sums = (long long*)malloc(sizeof(long long) * 100005);
    int level_sums_count = 0;

    while (head < tail) { // While queue is not empty
        int level_size = tail - head;
        long long current_level_sum = 0;

        for (int i = 0; i < level_size; ++i) {
            struct TreeNode* node = queue[head++];
            current_level_sum += node->val;

            if (node->left != NULL) {
                queue[tail++] = node->left;
            }
            if (node->right != NULL) {
                queue[tail++] = node->right;
            }
        }
        level_sums[level_sums_count++] = current_level_sum;
    }

    // Sort level_sums in descending order
    qsort(level_sums, level_sums_count, sizeof(long long), compareLongLong);

    // The Kth largest sum is at index k-1 (since k is 1-indexed)
    long long result = level_sums[k - 1];

    // Free allocated memory
    free(queue);
    free(level_sums);

    return result;
}