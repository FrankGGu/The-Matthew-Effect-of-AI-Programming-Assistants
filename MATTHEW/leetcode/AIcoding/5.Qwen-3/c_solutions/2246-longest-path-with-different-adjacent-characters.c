#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    char val;
    struct TreeNode** children;
    int childrenSize;
} TreeNode;

TreeNode* createNode(char val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->children = NULL;
    node->childrenSize = 0;
    return node;
}

void addEdge(TreeNode* root, char childVal) {
    TreeNode* child = createNode(childVal);
    root->children = (TreeNode**)realloc(root->children, sizeof(TreeNode*) * (root->childrenSize + 1));
    root->children[root->childrenSize++] = child;
}

int longestPathHelper(TreeNode* node, char parentChar, int* maxLen) {
    int firstMax = 0, secondMax = 0;
    for (int i = 0; i < node->childrenSize; i++) {
        TreeNode* child = node->children[i];
        if (child->val != parentChar) {
            int len = longestPathHelper(child, node->val, maxLen);
            if (len > firstMax) {
                secondMax = firstMax;
                firstMax = len;
            } else if (len > secondMax) {
                secondMax = len;
            }
        }
    }
    *maxLen = (*maxLen > firstMax + secondMax + 1) ? *maxLen : firstMax + secondMax + 1;
    return firstMax + 1;
}

int longestPath(char* root, int n) {
    TreeNode* rootTree = createNode(root[0]);
    for (int i = 1; i < n; i++) {
        TreeNode* current = rootTree;
        int j = 0;
        while (j < i) {
            if (current->childrenSize == 0) {
                addEdge(current, root[i]);
                break;
            }
            int found = 0;
            for (int k = 0; k < current->childrenSize; k++) {
                if (current->children[k]->val == root[j]) {
                    current = current->children[k];
                    j++;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                addEdge(current, root[i]);
                break;
            }
        }
    }
    int maxLen = 0;
    longestPathHelper(rootTree, '\0', &maxLen);
    return maxLen;
}