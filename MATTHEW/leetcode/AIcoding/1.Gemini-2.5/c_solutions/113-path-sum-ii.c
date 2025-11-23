#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#define MAX_PATH_LEN 5001 // Maximum possible depth of a binary tree on LeetCode (e.g., 5000 nodes skewed tree)

void dfs(struct TreeNode* node, int current_sum, int target_sum,
         int* current_path, int path_len,
         int*** result_ptr, int* return_size_ptr, int*** return_column_sizes_ptr) {

    if (node == NULL) {
        return;
    }

    current_path[path_len++] = node->val;
    current_sum += node->val;

    if (node->left == NULL && node->right == NULL) { // Leaf node
        if (current_sum == target_sum) {
            (*return_size_ptr)++;

            *result_ptr = (int**)realloc(*result_ptr, (*return_size_ptr) * sizeof(int*));
            *return_column_sizes_ptr = (int*)realloc(*return_column_sizes_ptr, (*return_size_ptr) * sizeof(int));

            int* new_path = (int*)malloc(path_len * sizeof(int));
            for (int i = 0; i < path_len; i++) {
                new_path[i] = current_path[i];
            }

            (*result_ptr)[(*return_size_ptr) - 1] = new_path;
            (*return_column_sizes_ptr)[(*return_size_ptr) - 1] = path_len;
        }
    } else { // Not a leaf node
        dfs(node->left, current_sum, target_sum, current_path, path_len,
            result_ptr, return_size_ptr, return_column_sizes_ptr);
        dfs(node->right, current_sum, target_sum, current_path, path_len,
            result_ptr, return_size_ptr, return_column_sizes_ptr);
    }
}

int** pathSum(struct TreeNode* root, int targetSum, int* returnSize, int** returnColumnSizes) {
    int** result = NULL;
    *returnSize = 0;
    *returnColumnSizes = NULL;

    int current_path[MAX_PATH_LEN];

    dfs(root, 0, targetSum, current_path, 0, &result, returnSize, returnColumnSizes);

    return result;
}