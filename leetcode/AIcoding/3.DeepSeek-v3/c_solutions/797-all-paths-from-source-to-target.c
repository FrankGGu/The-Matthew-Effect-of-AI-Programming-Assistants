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

    int* stack = (int*)malloc(graphSize * graphSize * sizeof(int));
    int* pathStack = (int*)malloc(graphSize * graphSize * sizeof(int));
    int stackIndex = 0;

    stack[stackIndex] = 0;
    pathStack[stackIndex] = 0;
    stackIndex++;

    while (stackIndex > 0) {
        stackIndex--;
        int node = stack[stackIndex];
        int pathIdx = pathStack[stackIndex];

        if (node == graphSize - 1) {
            result[*returnSize] = (int*)malloc((pathIdx + 1) * sizeof(int));
            for (int i = 0; i <= pathIdx; i++) {
                result[*returnSize][i] = path[i];
            }
            (*returnColumnSizes)[*returnSize] = pathIdx + 1;
            (*returnSize)++;
            continue;
        }

        for (int i = 0; i < graphColSize[node]; i++) {
            int nextNode = graph[node][i];
            path[pathIdx] = node;
            stack[stackIndex] = nextNode;
            pathStack[stackIndex] = pathIdx + 1;
            stackIndex++;
        }
    }

    free(path);
    free(stack);
    free(pathStack);

    return result;
}