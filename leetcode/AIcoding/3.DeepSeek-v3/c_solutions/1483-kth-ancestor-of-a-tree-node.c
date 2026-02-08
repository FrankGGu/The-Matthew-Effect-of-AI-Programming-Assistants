typedef struct {
    int** dp;
    int max_power;
    int n;
} TreeAncestor;

TreeAncestor* treeAncestorCreate(int n, int* parent, int parentSize) {
    TreeAncestor* obj = malloc(sizeof(TreeAncestor));
    obj->n = n;

    int max_power = 0;
    while ((1 << max_power) <= n) {
        max_power++;
    }
    obj->max_power = max_power;

    obj->dp = malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        obj->dp[i] = malloc(max_power * sizeof(int));
        for (int j = 0; j < max_power; j++) {
            obj->dp[i][j] = -1;
        }
    }

    for (int i = 0; i < n; i++) {
        obj->dp[i][0] = parent[i];
    }

    for (int j = 1; j < max_power; j++) {
        for (int i = 0; i < n; i++) {
            if (obj->dp[i][j-1] != -1) {
                obj->dp[i][j] = obj->dp[obj->dp[i][j-1]][j-1];
            }
        }
    }

    return obj;
}

int treeAncestorGetKthAncestor(TreeAncestor* obj, int node, int k) {
    int power = 0;
    while (k > 0 && node != -1) {
        if (k & 1) {
            if (power >= obj->max_power || node == -1) {
                return -1;
            }
            node = obj->dp[node][power];
        }
        k >>= 1;
        power++;
    }
    return node;
}

void treeAncestorFree(TreeAncestor* obj) {
    for (int i = 0; i < obj->n; i++) {
        free(obj->dp[i]);
    }
    free(obj->dp);
    free(obj);
}

/**
 * Your TreeAncestor struct will be instantiated and called as such:
 * TreeAncestor* obj = treeAncestorCreate(n, parent, parentSize);
 * int param_1 = treeAncestorGetKthAncestor(obj, node, k);
 * treeAncestorFree(obj);
 */