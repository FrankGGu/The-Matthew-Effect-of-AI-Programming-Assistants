#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    int *values;
    int size;
} List;

List* listCreate() {
    List *l = (List*)malloc(sizeof(List));
    l->size = 0;
    l->values = NULL;
    return l;
}

void listAdd(List *l, int value) {
    l->size++;
    l->values = (int*)realloc(l->values, l->size * sizeof(int));
    l->values[l->size - 1] = value;
}

void listFree(List *l) {
    free(l->values);
    free(l);
}

TreeNode* createTreeNode(int val) {
    TreeNode *node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

TreeNode* buildTree(int** edges, int edgesSize, int* edgeColSize, int n, int root) {
    TreeNode **nodes = (TreeNode**)malloc(n * sizeof(TreeNode*));
    for (int i = 0; i < n; i++) {
        nodes[i] = createTreeNode(i);
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        if (nodes[u]->left == NULL) {
            nodes[u]->left = nodes[v];
        } else {
            nodes[u]->right = nodes[v];
        }
    }

    return nodes[root];
}

long long maxScore(TreeNode *root, int *ans) {
    if (!root) return 0;
    long long left = maxScore(root->left, ans);
    long long right = maxScore(root->right, ans);
    long long total = left + right + root->val;
    *ans = (*ans > total ? *ans : total);
    return total;
}

int maxScoreAfterOperations(int** edges, int edgesSize, int* edgeColSize, int n, int root) {
    TreeNode *tree = buildTree(edges, edgesSize, edgeColSize, n, root);
    int ans = 0;
    maxScore(tree, &ans);
    return ans;
}