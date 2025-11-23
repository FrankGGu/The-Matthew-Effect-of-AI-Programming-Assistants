/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct TreeNode* createNode(int val) {
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void inorder(struct TreeNode* root, struct TreeNode** curr) {
    if (root == NULL) return;

    inorder(root->left, curr);

    (*curr)->right = createNode(root->val);
    *curr = (*curr)->right;

    inorder(root->right, curr);
}

struct TreeNode* increasingBST(struct TreeNode* root) {
    struct TreeNode* dummy = createNode(0);
    struct TreeNode* curr = dummy;

    inorder(root, &curr);

    struct TreeNode* result = dummy->right;
    free(dummy);
    return result;
}