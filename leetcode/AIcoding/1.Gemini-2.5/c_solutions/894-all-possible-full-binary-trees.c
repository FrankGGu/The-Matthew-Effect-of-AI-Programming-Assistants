#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

static struct TreeNode** memo_trees_g[21];
static int memo_sizes_g[21];

struct TreeNode** _generateAllFBT_memo(int n, int* returnSize) {
    if (memo_trees_g[n] != NULL) {
        *returnSize = memo_sizes_g[n];
        return memo_trees_g[n];
    }

    if (n == 0 || n % 2 == 0) {
        *returnSize = 0;
        memo_trees_g[n] = NULL;
        memo_sizes_g[n] = 0;
        return NULL;
    }

    if (n == 1) {
        struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        root->val = 0;
        root->left = NULL;
        root->right = NULL;

        struct TreeNode** result = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
        result[0] = root;
        *returnSize = 1;

        memo_trees_g[n] = result;
        memo_sizes_g[n] = 1;
        return result;
    }

    struct TreeNode** current_results = NULL;
    int current_count = 0;
    int current_capacity = 0;

    for (int i = 1; i < n; i += 2) {
        int left_size = 0;
        struct TreeNode** left_trees = _generateAllFBT_memo(i, &left_size);

        int right_size = 0;
        struct TreeNode** right_trees = _generateAllFBT_memo(n - 1 - i, &right_size);

        for (int l = 0; l < left_size; ++l) {
            for (int r = 0; r < right_size; ++r) {
                struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                root->val = 0;
                root->left = left_trees[l];
                root->right = right_trees[r];

                if (current_count == current_capacity) {
                    current_capacity = (current_capacity == 0) ? 1 : current_capacity * 2;
                    current_results = (struct TreeNode**)realloc(current_results, current_capacity * sizeof(struct TreeNode*));
                }
                current_results[current_count++] = root;
            }
        }
    }

    *returnSize = current_count;
    if (current_count > 0) {
        current_results = (struct TreeNode**)realloc(current_results, current_count * sizeof(struct TreeNode*));
    } else {
        free(current_results);
        current_results = NULL;
    }

    memo_trees_g[n] = current_results;
    memo_sizes_g[n] = current_count;
    return current_results;
}

struct TreeNode** allPossibleFBT(int n, int* returnSize) {
    return _generateAllFBT_memo(n, returnSize);
}