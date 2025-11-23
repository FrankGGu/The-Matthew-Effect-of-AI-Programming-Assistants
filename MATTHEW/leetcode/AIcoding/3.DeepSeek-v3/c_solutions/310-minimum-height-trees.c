/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findMinHeightTrees(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    if (n == 1) {
        *returnSize = 1;
        int* result = malloc(sizeof(int));
        result[0] = 0;
        return result;
    }

    int* degree = calloc(n, sizeof(int));
    int** graph = malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][degree[u]++] = v;
        graph[v][degree[v]++] = u;
    }

    int* leaves = malloc(n * sizeof(int));
    int leafCount = 0;

    for (int i = 0; i < n; i++) {
        if (degree[i] == 1) {
            leaves[leafCount++] = i;
        }
    }

    int remainingNodes = n;
    while (remainingNodes > 2) {
        int newLeafCount = 0;
        int* newLeaves = malloc(n * sizeof(int));

        for (int i = 0; i < leafCount; i++) {
            int leaf = leaves[i];
            for (int j = 0; j < degree[leaf]; j++) {
                int neighbor = graph[leaf][j];
                degree[neighbor]--;
                if (degree[neighbor] == 1) {
                    newLeaves[newLeafCount++] = neighbor;
                }
            }
            remainingNodes--;
        }

        free(leaves);
        leaves = newLeaves;
        leafCount = newLeafCount;
    }

    *returnSize = leafCount;
    int* result = malloc(leafCount * sizeof(int));
    for (int i = 0; i < leafCount; i++) {
        result[i] = leaves[i];
    }

    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    free(degree);
    free(leaves);

    return result;
}