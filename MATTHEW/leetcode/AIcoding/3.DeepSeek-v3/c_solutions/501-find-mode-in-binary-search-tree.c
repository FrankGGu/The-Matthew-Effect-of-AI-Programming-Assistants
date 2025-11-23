int* modes;
int modesSize;
int maxCount;
int currentVal;
int currentCount;

void traverse(struct TreeNode* node) {
    if (node == NULL) return;

    traverse(node->left);

    if (node->val == currentVal) {
        currentCount++;
    } else {
        currentVal = node->val;
        currentCount = 1;
    }

    if (currentCount > maxCount) {
        maxCount = currentCount;
        modesSize = 1;
    } else if (currentCount == maxCount) {
        if (modes != NULL) {
            modes[modesSize] = currentVal;
        }
        modesSize++;
    }

    traverse(node->right);
}

int* findMode(struct TreeNode* root, int* returnSize) {
    if (root == NULL) {
        *returnSize = 0;
        return NULL;
    }

    modes = NULL;
    modesSize = 0;
    maxCount = 0;
    currentVal = 0;
    currentCount = 0;

    traverse(root);

    modes = (int*)malloc(modesSize * sizeof(int));
    modesSize = 0;
    currentVal = 0;
    currentCount = 0;

    traverse(root);

    *returnSize = modesSize;
    return modes;
}