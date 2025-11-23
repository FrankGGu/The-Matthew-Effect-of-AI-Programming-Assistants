#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxAncestorDiffHelper(struct TreeNode* root, int maxAncestor, int minAncestor) {
    if (!root) {
        return maxAncestor - minAncestor;
    }

    maxAncestor = (root->val > maxAncestor) ? root->val : maxAncestor;
    minAncestor = (root->val < minAncestor) ? root->val : minAncestor;

    int leftDiff = maxAncestorDiffHelper(root->left, maxAncestor, minAncestor);
    int rightDiff = maxAncestorDiffHelper(root->right, maxAncestor, minAncestor);

    return (leftDiff > rightDiff) ? leftDiff : rightDiff;
}

int maxAncestorDiff(struct TreeNode* root) {
    if (!root) {
        return 0;
    }

    return maxAncestorDiffHelper(root, root->val, root->val);
}