#include <stdlib.h> // Required for abs()

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int totalTiltSum;

int calculateSubtreeSumAndTilt(struct TreeNode* node) {
    if (node == NULL) {
        return 0;
    }

    int leftSubtreeSum = calculateSubtreeSumAndTilt(node->left);
    int rightSubtreeSum = calculateSubtreeSumAndTilt(node->right);

    totalTiltSum += abs(leftSubtreeSum - rightSubtreeSum);

    return node->val + leftSubtreeSum + rightSubtreeSum;
}

int findTilt(struct TreeNode* root) {
    totalTiltSum = 0;
    calculateSubtreeSumAndTilt(root);
    return totalTiltSum;
}