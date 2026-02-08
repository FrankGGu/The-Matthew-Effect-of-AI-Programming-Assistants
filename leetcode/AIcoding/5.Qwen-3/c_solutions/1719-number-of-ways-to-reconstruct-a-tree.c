#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int* children;
    int size;
} TreeNode;

TreeNode* createNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->children = NULL;
    node->size = 0;
    return node;
}

void addEdge(TreeNode** nodes, int u, int v) {
    TreeNode* uNode = nodes[u];
    TreeNode* vNode = nodes[v];
    int* newChildren = (int*)realloc(uNode->children, (uNode->size + 1) * sizeof(int));
    newChildren[uNode->size++] = v;
    uNode->children = newChildren;

    newChildren = (int*)realloc(vNode->children, (vNode->size + 1) * sizeof(int));
    newChildren[vNode->size++] = u;
    vNode->children = newChildren;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int numberOfWays(int n, int** edges, int edgesSize, int* edgesColSize) {
    TreeNode** nodes = (TreeNode**)malloc(n * sizeof(TreeNode*));
    for (int i = 0; i < n; i++) {
        nodes[i] = createNode(i);
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        addEdge(nodes, u, v);
    }

    int* degrees = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        degrees[i] = nodes[i]->size;
    }

    int* sortedDegrees = (int*)malloc(n * sizeof(int));
    memcpy(sortedDegrees, degrees, n * sizeof(int));
    qsort(sortedDegrees, n, sizeof(int), compare);

    int count = 1;
    for (int i = 0; i < n; i++) {
        if (sortedDegrees[i] != degrees[i]) {
            count = 0;
            break;
        }
    }

    for (int i = 0; i < n; i++) {
        free(nodes[i]->children);
        free(nodes[i]);
    }
    free(nodes);
    free(degrees);
    free(sortedDegrees);

    return count;
}