/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

void getLeaves(struct TreeNode* root, int* leaves, int* index) {
    if (root == NULL) return;

    if (root->left == NULL && root->right == NULL) {
        leaves[(*index)++] = root->val;
        return;
    }

    getLeaves(root->left, leaves, index);
    getLeaves(root->right, leaves, index);
}

bool leafSimilar(struct TreeNode* root1, struct TreeNode* root2) {
    int leaves1[200];
    int leaves2[200];
    int index1 = 0;
    int index2 = 0;

    getLeaves(root1, leaves1, &index1);
    getLeaves(root2, leaves2, &index2);

    if (index1 != index2) return false;

    for (int i = 0; i < index1; i++) {
        if (leaves1[i] != leaves2[i]) return false;
    }

    return true;
}