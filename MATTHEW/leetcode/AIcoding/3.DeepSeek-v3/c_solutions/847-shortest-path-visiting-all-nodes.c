int shortestPathLength(int** graph, int graphSize, int* graphColSize) {
    if (graphSize == 1) return 0;

    int target = (1 << graphSize) - 1;
    int** visited = (int**)malloc(graphSize * sizeof(int*));
    for (int i = 0; i < graphSize; i++) {
        visited[i] = (int*)malloc((1 << graphSize) * sizeof(int));
        memset(visited[i], 0, (1 << graphSize) * sizeof(int));
    }

    int** queue = (int**)malloc(graphSize * (1 << graphSize) * sizeof(int*));
    for (int i = 0; i < graphSize * (1 << graphSize); i++) {
        queue[i] = (int*)malloc(2 * sizeof(int));
    }

    int front = 0, rear = 0;

    for (int i = 0; i < graphSize; i++) {
        int state = 1 << i;
        queue[rear][0] = i;
        queue[rear][1] = state;
        visited[i][state] = 1;
        rear++;
    }

    int steps = 0;
    while (front != rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int node = queue[front][0];
            int state = queue[front][1];
            front++;

            if (state == target) {
                for (int j = 0; j < graphSize * (1 << graphSize); j++) {
                    free(queue[j]);
                }
                free(queue);
                for (int j = 0; j < graphSize; j++) {
                    free(visited[j]);
                }
                free(visited);
                return steps;
            }

            for (int j = 0; j < graphColSize[node]; j++) {
                int neighbor = graph[node][j];
                int newState = state | (1 << neighbor);

                if (!visited[neighbor][newState]) {
                    visited[neighbor][newState] = 1;
                    queue[rear][0] = neighbor;
                    queue[rear][1] = newState;
                    rear++;
                }
            }
        }
        steps++;
    }

    for (int j = 0; j < graphSize * (1 << graphSize); j++) {
        free(queue[j]);
    }
    free(queue);
    for (int j = 0; j < graphSize; j++) {
        free(visited[j]);
    }
    free(visited);
    return -1;
}