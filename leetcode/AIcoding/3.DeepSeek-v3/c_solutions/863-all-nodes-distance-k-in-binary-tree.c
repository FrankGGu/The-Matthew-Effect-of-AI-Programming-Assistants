/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

#define MAX_SIZE 501

void buildParentMap(struct TreeNode* root, struct TreeNode* parent, struct TreeNode** parentMap) {
    if (root == NULL) return;
    parentMap[root->val] = parent;
    buildParentMap(root->left, root, parentMap);
    buildParentMap(root->right, root, parentMap);
}

void dfs(struct TreeNode* node, struct TreeNode* from, int distance, int k, int* result, int* index, struct TreeNode** parentMap) {
    if (node == NULL) return;
    if (distance == k) {
        result[(*index)++] = node->val;
        return;
    }
    if (node->left != from) {
        dfs(node->left, node, distance + 1, k, result, index, parentMap);
    }
    if (node->right != from) {
        dfs(node->right, node, distance + 1, k, result, index, parentMap);
    }
    struct TreeNode* parent = parentMap[node->val];
    if (parent != from) {
        dfs(parent, node, distance + 1, k, result, index, parentMap);
    }
}

int* distanceK(struct TreeNode* root, struct TreeNode* target, int k, int* returnSize) {
    struct TreeNode* parentMap[MAX_SIZE] = {NULL};
    buildParentMap(root, NULL, parentMap);

    int* result = (int*)malloc(MAX_SIZE * sizeof(int));
    *returnSize = 0;

    dfs(target, NULL, 0, k, result, returnSize, parentMap);

    return result;
}