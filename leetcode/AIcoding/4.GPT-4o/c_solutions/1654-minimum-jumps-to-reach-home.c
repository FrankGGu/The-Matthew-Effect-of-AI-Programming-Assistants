int minimumJumps(int* forbidden, int forbiddenSize, int a, int b, int x) {
    int limit = 2000 + a + b;
    int* visited = (int*)calloc(limit, sizeof(int));
    for (int i = 0; i < forbiddenSize; i++) {
        if (forbidden[i] < limit) {
            visited[forbidden[i]] = 1;
        }
    }

    int queue[limit * 2];
    int front = 0, rear = 0;
    queue[rear++] = 0; // Start from position 0
    int jumps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int pos = queue[front++];
            if (pos == x) {
                free(visited);
                return jumps;
            }
            if (pos + a < limit && !visited[pos + a]) {
                visited[pos + a] = 1;
                queue[rear++] = pos + a;
            }
            if (pos - b >= 0 && !visited[pos - b]) {
                visited[pos - b] = 1;
                queue[rear++] = pos - b;
            }
        }
        jumps++;
    }

    free(visited);
    return -1;
}