#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode** delNodes(struct TreeNode* root, int* to_delete, int to_deleteSize, int* returnSize){
    struct TreeNode** result = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 1000);
    *returnSize = 0;

    bool isDeleted[1001] = {false};
    for(int i = 0; i < to_deleteSize; i++){
        isDeleted[to_delete[i]] = true;
    }

    struct TreeNode* dfs(struct TreeNode* node, bool isRoot, bool isDeletedArr[]) {
        if (!node) return NULL;

        bool deleted = isDeletedArr[node->val];
        node->left = dfs(node->left, deleted, isDeletedArr);
        node->right = dfs(node->right, deleted, isDeletedArr);

        if (deleted) {
            free(node);
            return NULL;
        } else {
            if (isRoot) {
                result[(*returnSize)++] = node;
            }
            return node;
        }
    }

    if (root) {
        struct TreeNode* res = dfs(root, true, isDeleted);
        if (res) {
           // result[(*returnSize)++] = res;
        }
    }

    return result;
}