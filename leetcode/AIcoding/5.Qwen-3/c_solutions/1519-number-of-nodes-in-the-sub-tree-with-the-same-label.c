#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    char label;
    struct TreeNode* children;
    int childCount;
} TreeNode;

TreeNode* createNode(char label) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->label = label;
    node->children = NULL;
    node->childCount = 0;
    return node;
}

void addChildren(TreeNode* parent, TreeNode* child) {
    parent->children = (TreeNode*)realloc(parent->children, (parent->childCount + 1) * sizeof(TreeNode));
    parent->children[parent->childCount++] = *child;
}

int* countNodes(struct TreeNode* root, char* labels, int* returnSize) {
    int* result = (int*)calloc(26, sizeof(int));
    if (!root) return result;

    int* counts = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < root->childCount; i++) {
        int* childCounts = countNodes(&root->children[i], labels, returnSize);
        for (int j = 0; j < 26; j++) {
            counts[j] += childCounts[j];
        }
        free(childCounts);
    }

    int index = root->label - 'a';
    counts[index]++;
    result[index] = counts[index];

    *returnSize = 26;
    return result;
}

int* countSubTrees(int n, int* edges, int edgesSize, char* labels, int* returnSize) {
    TreeNode** nodes = (TreeNode**)calloc(n, sizeof(TreeNode*));
    for (int i = 0; i < n; i++) {
        nodes[i] = createNode(labels[i]);
    }

    for (int i = 0; i < edgesSize; i += 2) {
        int u = edges[i];
        int v = edges[i + 1];
        addChildren(nodes[u], nodes[v]);
        addChildren(nodes[v], nodes[u]);
    }

    int* result = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < n; i++) {
        int* counts = countNodes(nodes[i], labels, returnSize);
        for (int j = 0; j < 26; j++) {
            result[j] += counts[j];
        }
        free(counts);
    }

    *returnSize = 26;
    return result;
}