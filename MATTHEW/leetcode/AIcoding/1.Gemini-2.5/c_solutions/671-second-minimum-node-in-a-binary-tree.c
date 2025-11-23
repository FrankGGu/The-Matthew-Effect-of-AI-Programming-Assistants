long long secondMinVal;

void findSecondMinimumHelper(struct TreeNode* node, int firstMin) {
    if (node == NULL) {
        return;
    }

    if (node->val == firstMin) {
        findSecondMinimumHelper(node->left, firstMin);
        findSecondMinimumHelper(node->right, firstMin);
    } else {
        if (secondMinVal == -1 || node->val < secondMinVal) {
            secondMinVal = node->val;
        }
    }
}

int findSecondMinimumValue(struct TreeNode* root) {
    if (root == NULL) {
        return -1;
    }

    int firstMin = root->val;
    secondMinVal = -1;

    findSecondMinimumHelper(root, firstMin);

    return (int)secondMinVal;
}