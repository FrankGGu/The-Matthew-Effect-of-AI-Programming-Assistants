int* findMode(struct TreeNode* root, int* returnSize) {
    int* modes = (int*)malloc(sizeof(int) * 10000);
    int maxCount = 0, count = 0, currentVal = 0;
    *returnSize = 0;

    void inorder(struct TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        if (currentVal != node->val) {
            currentVal = node->val;
            count = 1;
        } else {
            count++;
        }
        if (count > maxCount) {
            maxCount = count;
            *returnSize = 1;
            modes[0] = currentVal;
        } else if (count == maxCount) {
            modes[*returnSize] = currentVal;
            (*returnSize)++;
        }
        inorder(node->right);
    }

    inorder(root);
    return modes;
}