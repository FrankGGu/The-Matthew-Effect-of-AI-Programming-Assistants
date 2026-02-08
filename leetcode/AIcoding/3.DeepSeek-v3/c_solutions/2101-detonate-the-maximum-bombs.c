int maximumDetonation(int** bombs, int bombsSize, int* bombsColSize) {
    int maxCount = 0;

    for (int i = 0; i < bombsSize; i++) {
        int count = 0;
        int* visited = (int*)calloc(bombsSize, sizeof(int));
        int* queue = (int*)malloc(bombsSize * sizeof(int));
        int front = 0, rear = 0;

        visited[i] = 1;
        queue[rear++] = i;
        count++;

        while (front < rear) {
            int current = queue[front++];
            long long x1 = bombs[current][0];
            long long y1 = bombs[current][1];
            long long r1 = bombs[current][2];

            for (int j = 0; j < bombsSize; j++) {
                if (!visited[j]) {
                    long long dx = bombs[j][0] - x1;
                    long long dy = bombs[j][1] - y1;
                    if (dx * dx + dy * dy <= r1 * r1) {
                        visited[j] = 1;
                        queue[rear++] = j;
                        count++;
                    }
                }
            }
        }

        if (count > maxCount) {
            maxCount = count;
        }

        free(visited);
        free(queue);
    }

    return maxCount;
}