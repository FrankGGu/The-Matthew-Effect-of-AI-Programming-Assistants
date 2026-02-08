int countVisitedNodes(int n, int** edges, int edgesSize, int* edgesColSize, int start) {
    int *visited = (int *)calloc(n, sizeof(int));
    int count = 0;
    int *stack = (int *)malloc(n * sizeof(int));
    int top = -1;

    stack[++top] = start;

    while (top >= 0) {
        int node = stack[top--];
        if (!visited[node]) {
            visited[node] = 1;
            count++;
            for (int i = 0; i < edgesSize; i++) {
                if (edges[i][0] == node && !visited[edges[i][1]]) {
                    stack[++top] = edges[i][1];
                }
            }
        }
    }

    free(visited);
    free(stack);

    return count;
}