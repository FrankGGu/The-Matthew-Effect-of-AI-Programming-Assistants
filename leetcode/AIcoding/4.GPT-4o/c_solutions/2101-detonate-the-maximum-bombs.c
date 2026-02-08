int maxDetonatedBombs(int** bombs, int bombsSize, int* bombsColSize) {
    int maxDetonated = 0;

    for (int i = 0; i < bombsSize; i++) {
        int detonated = 0;
        int* visited = (int*)calloc(bombsSize, sizeof(int));
        int queue[1000][2], front = 0, rear = 0;

        queue[rear][0] = bombs[i][0];
        queue[rear][1] = bombs[i][1];
        visited[i] = 1;
        rear++;

        while (front < rear) {
            int x = queue[front][0];
            int y = queue[front][1];
            front++;
            detonated++;

            for (int j = 0; j < bombsSize; j++) {
                if (!visited[j]) {
                    long long dx = (long long)bombs[j][0] - x;
                    long long dy = (long long)bombs[j][1] - y;
                    long long distance = dx * dx + dy * dy;
                    long long radius = (long long)bombs[i][2] * (long long)bombs[i][2];
                    if (distance <= radius) {
                        queue[rear][0] = bombs[j][0];
                        queue[rear][1] = bombs[j][1];
                        visited[j] = 1;
                        rear++;
                    }
                }
            }
        }
        maxDetonated = maxDetonated > detonated ? maxDetonated : detonated;
        free(visited);
    }

    return maxDetonated;
}