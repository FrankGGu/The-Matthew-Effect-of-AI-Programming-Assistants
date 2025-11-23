#include <stdlib.h> // For malloc, free

typedef struct {
    int* tree; // Segment tree array
    int n;     // Size of the original array
} NumArray;

void build(NumArray* obj, int* nums, int node, int start, int end) {
    if (start == end) {
        // Leaf node: stores the actual array element
        obj->tree[node] = nums[start];
    } else {
        int mid = start + (end - start) / 2;
        // Recursively build left and right children
        build(obj, nums, 2 * node, start, mid);
        build(obj, nums, 2 * node + 1, mid + 1, end);
        // Internal node: stores the sum of its children
        obj->tree[node] = obj->tree[2 * node] + obj->tree[2 * node + 1];
    }
}

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray* obj = (NumArray*)malloc(sizeof(NumArray));
    obj->n = numsSize;
    // A segment tree usually requires 4*N space in the worst case
    // Given constraints 1 <= nums.length, numsSize will always be >= 1
    obj->tree = (int*)malloc(4 * numsSize * sizeof(int));

    build(obj, nums, 1, 0, numsSize - 1);

    return obj;
}

void update_tree(NumArray* obj, int node, int start, int end, int idx, int val) {
    if (start == end) {
        // Leaf node: update the value
        obj->tree[node] = val;
    } else {
        int mid = start + (end - start) / 2;
        if (start <= idx && idx <= mid) {
            // idx is in the left child's range
            update_tree(obj, 2 * node, start, mid, idx, val);
        } else {
            // idx is in the right child's range
            update_tree(obj, 2 * node + 1, mid + 1, end, idx, val);
        }
        // Update current node's sum based on its children
        obj->tree[node] = obj->tree[2 * node] + obj->tree[2 * node + 1];
    }
}

void numArrayUpdate(NumArray* obj, int index, int val) {
    update_tree(obj, 1, 0, obj->n - 1, index, val);
}

int query_tree(NumArray* obj, int node, int start, int end, int l, int r) {
    // Case 1: Current node's range is completely outside the query range
    if (r < start || end < l) {
        return 0;
    }
    // Case 2: Current node's range is completely inside the query range
    if (l <= start && end <= r) {
        return obj->tree[node];
    }
    // Case 3: Current node's range partially overlaps the query range
    int mid = start + (end - start) / 2;
    int p1 = query_tree(obj, 2 * node, start, mid, l, r);
    int p2 = query_tree(obj, 2 * node + 1, mid + 1, end, l, r);
    return p1 + p2;
}

int numArraySumRange(NumArray* obj, int left, int right) {
    return query_tree(obj, 1, 0, obj->n - 1, left, right);
}

void numArrayFree(NumArray* obj) {
    free(obj->tree);
    free(obj);
}