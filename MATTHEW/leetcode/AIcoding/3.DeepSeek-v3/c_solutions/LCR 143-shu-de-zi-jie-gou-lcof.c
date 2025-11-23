/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

bool isSubStructureHelper(struct TreeNode* A, struct TreeNode* B) {
    if (B == NULL) return true;
    if (A == NULL) return false;
    if (A->val != B->val) return false;
    return isSubStructureHelper(A->left, B->left) && isSubStructureHelper(A->right, B->right);
}

bool isSubStructure(struct TreeNode* A, struct TreeNode* B) {
    if (A == NULL || B == NULL) return false;
    return isSubStructureHelper(A, B) || isSubStructure(A->left, B) || isSubStructure(A->right, B);
}