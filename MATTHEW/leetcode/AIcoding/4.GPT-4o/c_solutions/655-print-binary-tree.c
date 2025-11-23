char*** printTree(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (!root) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int height = 0;
    struct TreeNode* node = root;
    while (node) {
        height++;
        node = node->left ? node->left : node->right;
    }

    int rows = height;
    int cols = (1 << height) - 1;
    char*** result = (char***)malloc(rows * sizeof(char**));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        result[i] = (char**)malloc(cols * sizeof(char*));
        for (int j = 0; j < cols; j++) {
            result[i][j] = "";
        }
        (*returnColumnSizes)[i] = cols;
    }

    void fillTree(struct TreeNode* node, int row, int left, int right) {
        if (!node) return;
        int mid = left + (right - left) / 2;
        result[row][mid] = (char*)malloc(12 * sizeof(char));
        sprintf(result[row][mid], "%d", node->val);
        fillTree(node->left, row + 1, left, mid - 1);
        fillTree(node->right, row + 1, mid + 1, right);
    }

    fillTree(root, 0, 0, cols - 1);
    *returnSize = rows;
    return result;
}