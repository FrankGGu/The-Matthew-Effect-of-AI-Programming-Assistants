int maxDistance(int** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    int queue[gridSize * gridSize][2];
    int front = 0, rear = 0;
    int maxDist = -1;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == 1) {
                queue[rear][0] = i;
                queue[rear][1] = j;
                rear++;
            }
        }
    }

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int x = queue[front][0];
            int y = queue[front][1];
            front++;

            for (int d = 0; d < 4; d++) {
                int newX = x + directions[d][0];
                int newY = y + directions[d][1];
                if (newX >= 0 && newY >= 0 && newX < gridSize && newY < gridColSize[newX] && grid[newX][newY] == 0) {
                    grid[newX][newY] = 1;
                    queue[rear][0] = newX;
                    queue[rear][1] = newY;
                    rear++;
                }
            }
        }
        maxDist++;
    }

    return maxDist == -1 ? -1 : maxDist;
}