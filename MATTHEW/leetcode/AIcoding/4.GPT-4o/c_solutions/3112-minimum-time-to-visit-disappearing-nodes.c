int minimumTime(int** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    int rows = gridSize, cols = gridColSize[0];
    int time[rows][cols];
    memset(time, -1, sizeof(time));
    time[0][0] = 0;

    struct Node {
        int x, y, t;
    };

    struct Node queue[rows * cols];
    int front = 0, rear = 0;
    queue[rear++] = (struct Node){0, 0, 0};

    while (front < rear) {
        struct Node curr = queue[front++];

        for (int i = 0; i < 4; i++) {
            int newX = curr.x + directions[i][0];
            int newY = curr.y + directions[i][1];
            if (newX >= 0 && newX < rows && newY >= 0 && newY < cols) {
                int waitTime = grid[newX][newY] - (curr.t + 1);
                if (waitTime < 0) waitTime = 0;
                int newTime = curr.t + 1 + waitTime;
                if (time[newX][newY] == -1 || newTime < time[newX][newY]) {
                    time[newX][newY] = newTime;
                    queue[rear++] = (struct Node){newX, newY, newTime};
                }
            }
        }
    }

    return time[rows - 1][cols - 1];
}