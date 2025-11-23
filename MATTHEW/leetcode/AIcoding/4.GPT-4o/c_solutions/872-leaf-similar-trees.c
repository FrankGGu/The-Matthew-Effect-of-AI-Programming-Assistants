void collectLeaves(struct TreeNode* root, int* leaves, int* returnSize) {
    if (!root) return;
    if (!root->left && !root->right) {
        leaves[(*returnSize)++] = root->val;
    }
    collectLeaves(root->left, leaves, returnSize);
    collectLeaves(root->right, leaves, returnSize);
}

bool leafSimilar(struct TreeNode* root1, struct TreeNode* root2) {
    int leaves1[1000], leaves2[1000], size1 = 0, size2 = 0;
    collectLeaves(root1, leaves1, &size1);
    collectLeaves(root2, leaves2, &size2);
    if (size1 != size2) return false;
    for (int i = 0; i < size1; i++) {
        if (leaves1[i] != leaves2[i]) return false;
    }
    return true;
}