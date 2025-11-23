/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct TreeNode* getTargetCopy(struct TreeNode* original, struct TreeNode* cloned, struct TreeNode* target) {
    if (original == NULL) return NULL;
    if (original == target) return cloned;

    struct TreeNode* left = getTargetCopy(original->left, cloned->left, target);
    if (left != NULL) return left;

    struct TreeNode* right = getTargetCopy(original->right, cloned->right, target);
    return right;
}