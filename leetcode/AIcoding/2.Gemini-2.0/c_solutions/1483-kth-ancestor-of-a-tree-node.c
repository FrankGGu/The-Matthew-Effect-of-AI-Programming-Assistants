#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int** parent;
    int max_depth;
    int n;
} TreeAncestor;

TreeAncestor* treeAncestorCreate(int n, int* parent, int parentSize) {
    TreeAncestor* obj = (TreeAncestor*)malloc(sizeof(TreeAncestor));
    obj->n = n;
    obj->max_depth = 0;
    int temp = n;
    while (temp > 0) {
        temp >>= 1;
        obj->max_depth++;
    }

    obj->parent = (int**)malloc(sizeof(int*) * n);
    for (int i = 0; i < n; i++) {
        obj->parent[i] = (int*)malloc(sizeof(int) * (obj->max_depth + 1));
        for (int j = 0; j <= obj->max_depth; j++) {
            obj->parent[i][j] = -1;
        }
    }

    for (int i = 0; i < n; i++) {
        obj->parent[i][0] = parent[i];
    }

    for (int j = 1; j <= obj->max_depth; j++) {
        for (int i = 0; i < n; i++) {
            if (obj->parent[i][j - 1] != -1) {
                obj->parent[i][j] = obj->parent[obj->parent[i][j - 1]][j - 1];
            }
        }
    }

    return obj;
}

int treeAncestorGetKthAncestor(TreeAncestor* obj, int node, int k) {
    for (int i = 0; i <= obj->max_depth; i++) {
        if ((k >> i) & 1) {
            if (node == -1) return -1;
            node = obj->parent[node][i];
        }
    }
    return node;
}

void treeAncestorFree(TreeAncestor* obj) {
    for (int i = 0; i < obj->n; i++) {
        free(obj->parent[i]);
    }
    free(obj->parent);
    free(obj);
}