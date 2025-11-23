/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** allPathsSourceTarget(int** graph, int graphSize, int* graphColSize, int* returnSize, int** returnColumnSizes) {
    int maxPaths = 10000;
    int** result = (int**)malloc(maxPaths * sizeof(int*));
    *returnColumnSizes = (int*)malloc(maxPaths * sizeof(int));
    *returnSize = 0;

    int* path = (int*)malloc(graphSize * sizeof(int));
    int pathIndex = 0;

    void dfs(int node) {
        path[pathIndex++] = node;

        if (node == graphSize - 1) {
            result[*returnSize] = (int*)malloc(pathIndex * sizeof(int));
            for (int i = 0; i < pathIndex; i++) {
                result[*returnSize][i] = path[i];
            }
            (*returnColumnSizes)[*returnSize] = pathIndex;
            (*returnSize)++;
            pathIndex--;
            return;
        }

        for (int i = 0; i < graphColSize[node]; i++) {
            dfs(graph[node][i]);
        }

        pathIndex--;
    }

    dfs(0);

    free(path);
    return result;
}