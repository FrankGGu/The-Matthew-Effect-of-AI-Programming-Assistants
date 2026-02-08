#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* sizes_arr;
int sizes_count;
int sizes_capacity;

void add_size(int size) {
    if (sizes_count == sizes_capacity) {
        sizes_capacity = sizes_capacity == 0 ? 1 : sizes_capacity * 2;
        sizes_arr = (int*)realloc(sizes_arr, sizes_capacity * sizeof(int));
    }
    sizes_arr[sizes_count++] = size;
}

int collect_perfect_subtree_sizes_dfs(struct TreeNode* node) {
    if (node == NULL) {
        return 0;
    }

    int left_height = collect_perfect_subtree_sizes_dfs(node->left);
    int right_height = collect_perfect_subtree_sizes_dfs(node->right);

    if (left_height == -1 || right_height == -1 || left_height != right_height) {
        return -1;
    }

    int current_height = left_height + 1;
    int current_size = (1 << current_height) - 1;
    add_size(current_size);

    return current_height;
}

int compare_ints_desc(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int kthLargestPerfectSubtreeSize(struct TreeNode* root, int k) {
    sizes_arr = NULL;
    sizes_count = 0;
    sizes_capacity = 0;

    collect_perfect_subtree_sizes_dfs(root);

    qsort(sizes_arr, sizes_count, sizeof(int), compare_ints_desc);

    int result = sizes_arr[k - 1];

    free(sizes_arr);
    sizes_arr = NULL;

    return result;
}