/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* subtreeSizesAfterChanges(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    *returnSize = n;
    int* res = (int*)malloc(n * sizeof(int));
    int* adj[n];
    int adjSize[n];
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        adjSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        adj[u][adjSize[u]++] = v;
        adj[v][adjSize[v]++] = u;
    }

    int parent[n];
    int order[n];
    int idx = 0;
    int stack[n];
    int top = 0;
    stack[top++] = 0;
    parent[0] = -1;
    while (top > 0) {
        int u = stack[--top];
        order[idx++] = u;
        for (int i = 0; i < adjSize[u]; i++) {
            int v = adj[u][i];
            if (v != parent[u]) {
                parent[v] = u;
                stack[top++] = v;
            }
        }
    }

    int size[n];
    char label[n+1];
    for (int i = 0; i < n; i++) {
        size[i] = 1;
        label[i] = 'a';
    }

    for (int i = n-1; i >= 0; i--) {
        int u = order[i];
        int maxChild = -1;
        char maxChar = 'a';
        for (int j = 0; j < adjSize[u]; j++) {
            int v = adj[u][j];
            if (v == parent[u]) continue;
            if (label[v] > maxChar || (label[v] == maxChar && size[v] > maxChild)) {
                maxChar = label[v];
                maxChild = size[v];
            }
        }

        if (maxChild != -1) {
            label[u] = maxChar;
            size[u] = 1;
            for (int j = 0; j < adjSize[u]; j++) {
                int v = adj[u][j];
                if (v == parent[u]) continue;
                if (label[v] == maxChar) {
                    size[u] += size[v];
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        res[i] = size[i];
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }

    return res;
}