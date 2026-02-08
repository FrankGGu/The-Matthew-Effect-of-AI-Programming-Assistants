#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* createTreeNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

TreeNode* createBinaryTree(int** descriptions, int descriptionsSize, int* descriptionsColSize) {
    int i;
    TreeNode* nodes[1001] = {NULL};
    int hasParent[1001] = {0};

    for (i = 0; i < descriptionsSize; i++) {
        int parentVal = descriptions[i][0];
        int childVal = descriptions[i][1];
        int isLeft = descriptions[i][2];

        if (!nodes[parentVal]) {
            nodes[parentVal] = createTreeNode(parentVal);
        }
        if (!nodes[childVal]) {
            nodes[childVal] = createTreeNode(childVal);
        }

        hasParent[childVal] = 1;

        if (isLeft) {
            nodes[parentVal]->left = nodes[childVal];
        } else {
            nodes[parentVal]->right = nodes[childVal];
        }
    }

    for (i = 0; i <= 1000; i++) {
        if (nodes[i] && !hasParent[i]) {
            return nodes[i];
        }
    }

    return NULL;
}