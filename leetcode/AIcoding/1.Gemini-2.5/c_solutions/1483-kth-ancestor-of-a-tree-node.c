#include <stdlib.h>

#define MAXN 50000
#define LOGN 17

typedef struct {
    int n;
    int up[MAXN][LOGN];
} TreeAncestor;

TreeAncestor* treeAncestorCreate(int n, int* parent, int parentSize) {
    TreeAncestor* obj = (TreeAncestor*)malloc(sizeof(TreeAncestor));
    obj->n = n;

    for (int i = 0; i < n; ++i) {
        obj->up[i][0] = parent[i];
    }

    for (int j = 1; j < LOGN; ++j) {
        for (int i = 0; i < n; ++i) {
            if (obj->up[i][j-1] != -1) {
                obj->up[i][j] = obj->up[obj->up[i][j-1]][j-1];
            } else {
                obj->up[i][j] = -1;
            }
        }
    }
    return obj;
}

int treeAncestorGetKthAncestor(TreeAncestor* obj, int node, int k) {
    for (int j = LOGN - 1; j >= 0; --j) {
        if (node == -1) {
            break;
        }
        if ((k >> j) & 1) {
            node = obj->up[node][j];
        }
    }
    return node;
}

void treeAncestorFree(TreeAncestor* obj) {
    free(obj);
}