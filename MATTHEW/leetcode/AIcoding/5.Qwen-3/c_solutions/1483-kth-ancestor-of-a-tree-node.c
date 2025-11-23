#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *parent;
    int n;
} TreeAncestor;

TreeAncestor* treeAncestorCreate(int n, int* k, int* q) {
    TreeAncestor* obj = (TreeAncestor*)malloc(sizeof(TreeAncestor));
    obj->n = n;
    obj->parent = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        obj->parent[i] = k[i];
    }
    return obj;
}

int treeAncestorGetKthAncestor(int* obj, int node, int k) {
    while (k > 0 && node != -1) {
        node = obj->parent[node];
        k--;
    }
    return node;
}

void treeAncestorFree(TreeAncestor* obj) {
    free(obj->parent);
    free(obj);
}