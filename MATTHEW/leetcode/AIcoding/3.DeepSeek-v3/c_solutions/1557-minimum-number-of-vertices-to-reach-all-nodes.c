/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findSmallestSetOfVertices(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int* indegree = calloc(n, sizeof(int));
    for (int i = 0; i < edgesSize; i++) {
        indegree[edges[i][1]]++;
    }

    int* result = malloc(n * sizeof(int));
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (indegree[i] == 0) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    free(indegree);
    return result;
}