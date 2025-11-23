int max(int a, int b) {
    return (a > b) ? a : b;
}

int calculateHeightAndDiameter(struct TreeNode* node, int* max_diameter) {
    if (node == NULL) {
        return 0;
    }

    int left_height = calculateHeightAndDiameter(node->left, max_diameter);
    int right_height = calculateHeightAndDiameter(node->right, max_diameter);

    *max_diameter = max(*max_diameter, left_height + right_height);

    return 1 + max(left_height, right_height);
}

int diameterOfBinaryTree(struct TreeNode* root) {
    int max_d = 0;
    calculateHeightAndDiameter(root, &max_d);
    return max_d;
}