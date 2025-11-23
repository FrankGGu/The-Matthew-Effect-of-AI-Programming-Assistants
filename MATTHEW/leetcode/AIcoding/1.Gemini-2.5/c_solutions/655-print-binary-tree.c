#include <stdlib.h>
#include <string.h>
#include <stdio.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int getHeight(struct TreeNode* root) {
    if (root == NULL) {
        return -1;
    }
    int leftHeight = getHeight(root->left);
    int rightHeight = getHeight(root->right);
    return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);
}

void placeNode(struct TreeNode* node, char*** result, int row, int col, int totalHeight) {
    if (node == NULL) {
        return;
    }

    char* valStr = (char*)malloc(sizeof(char) * 5); 
    sprintf(valStr, "%d", node->val);
    result[row][col] = valStr;

    int offset = 1 << (totalHeight - row - 1);

    if (node->left != NULL) {
        placeNode(node->left, result, row + 1, col - offset, totalHeight);
    }

    if (node->right != NULL) {
        placeNode(node->right, result, row + 1, col + offset, totalHeight);
    }
}

char*** printTree(struct TreeNode* root, int* returnSize, int** returnColumnSizes) {
    if (root == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int h = getHeight(root);
    int m = h + 1;
    int n = (1 << (h + 1)) - 1;

    *returnColumnSizes = (int*)malloc(sizeof(int) * m);
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }
    *returnSize = m;

    char*** result = (char***)malloc(sizeof(char**) * m);
    for (int i = 0; i < m; i++) {
        result[i] = (char**)malloc(sizeof(char*) * n);
        for (int j = 0; j < n; j++) {
            result[i][j] = (char*)malloc(sizeof(char) * 2); 
            strcpy(result[i][j], "");
        }
    }

    placeNode(root, result, 0, (n - 1) / 2, h);

    return result;
}