struct TreeNode* getTargetCopy(struct TreeNode* original, struct TreeNode* cloned, struct TreeNode* target) {
    if (original == NULL) {
        return NULL;
    }
    if (original == target) {
        return cloned;
    }

    struct TreeNode* leftResult = getTargetCopy(original->left, cloned->left, target);
    if (leftResult != NULL) {
        return leftResult;
    }

    return getTargetCopy(original->right, cloned->right, target);
}