struct TreeNode* getTargetCopy(struct TreeNode* original, struct TreeNode* cloned, struct TreeNode* target) {
    if (!cloned) return NULL;
    if (original == target) return cloned;

    struct TreeNode* left = getTargetCopy(original->left, cloned->left, target);
    if (left) return left;

    return getTargetCopy(original->right, cloned->right, target);
}