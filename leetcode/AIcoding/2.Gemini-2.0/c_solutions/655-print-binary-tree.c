#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int treeHeight(struct TreeNode* root) {
    if (!root) return 0;
    int leftHeight = treeHeight(root->left);
    int rightHeight = treeHeight(root->right);
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
}

void fillMatrix(struct TreeNode* root, char*** matrix, int row, int start, int end, int height) {
    if (!root) return;
    int mid = (start + end) / 2;
    char valStr[12];
    sprintf(valStr, "%d", root->val);
    strcpy(matrix[row][mid], valStr);
    fillMatrix(root->left, matrix, row + 1, start, mid - 1, height);
    fillMatrix(root->right, matrix, row + 1, mid + 1, end, height);
}

char*** printTree(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    int height = treeHeight(root);
    int width = (1 << height) - 1;

    char*** matrix = (char***)malloc(height * sizeof(char**));
    *returnColumnSizes = (int*)malloc(height * sizeof(int));
    *returnSize = height;

    for (int i = 0; i < height; i++) {
        matrix[i] = (char**)malloc(width * sizeof(char*));
        (*returnColumnSizes)[i] = width;
        for (int j = 0; j < width; j++) {
            matrix[i][j] = (char*)malloc(3 * sizeof(char));
            strcpy(matrix[i][j], "");
        }
    }

    fillMatrix(root, matrix, 0, 0, width - 1, height);

    return matrix;
}