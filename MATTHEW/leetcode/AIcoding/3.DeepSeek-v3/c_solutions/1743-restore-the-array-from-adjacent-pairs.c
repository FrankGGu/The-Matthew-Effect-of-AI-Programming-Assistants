/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* restoreArray(int** adjacentPairs, int adjacentPairsSize, int* adjacentPairsColSize, int* returnSize) {
    int n = adjacentPairsSize + 1;
    *returnSize = n;
    int* res = (int*)malloc(n * sizeof(int));

    // Create adjacency list using a hash map
    int minVal = 1000000, maxVal = -1000000;
    for (int i = 0; i < adjacentPairsSize; i++) {
        int a = adjacentPairs[i][0];
        int b = adjacentPairs[i][1];
        if (a < minVal) minVal = a;
        if (a > maxVal) maxVal = a;
        if (b < minVal) minVal = b;
        if (b > maxVal) maxVal = b;
    }

    int offset = -minVal;
    int size = maxVal - minVal + 1;

    int** adj = (int**)malloc(size * sizeof(int*));
    int* adjSize = (int*)calloc(size, sizeof(int));
    int* adjCapacity = (int*)malloc(size * sizeof(int));

    for (int i = 0; i < size; i++) {
        adjCapacity[i] = 2;
        adj[i] = (int*)malloc(2 * sizeof(int));
    }

    for (int i = 0; i < adjacentPairsSize; i++) {
        int a = adjacentPairs[i][0] + offset;
        int b = adjacentPairs[i][1] + offset;

        if (adjSize[a] >= adjCapacity[a]) {
            adjCapacity[a] *= 2;
            adj[a] = (int*)realloc(adj[a], adjCapacity[a] * sizeof(int));
        }
        adj[a][adjSize[a]++] = b;

        if (adjSize[b] >= adjCapacity[b]) {
            adjCapacity[b] *= 2;
            adj[b] = (int*)realloc(adj[b], adjCapacity[b] * sizeof(int));
        }
        adj[b][adjSize[b]++] = a;
    }

    // Find starting point (node with only one neighbor)
    int start = -1;
    for (int i = 0; i < size; i++) {
        if (adjSize[i] == 1) {
            start = i;
            break;
        }
    }

    // Reconstruct the array
    res[0] = start - offset;
    int prev = start;
    int curr = adj[start][0];

    for (int i = 1; i < n; i++) {
        res[i] = curr - offset;

        // Find next node
        int next = -1;
        for (int j = 0; j < adjSize[curr]; j++) {
            if (adj[curr][j] != prev) {
                next = adj[curr][j];
                break;
            }
        }

        prev = curr;
        curr = next;
    }

    // Free memory
    for (int i = 0; i < size; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSize);
    free(adjCapacity);

    return res;
}