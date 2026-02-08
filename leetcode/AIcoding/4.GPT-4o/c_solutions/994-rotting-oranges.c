int orangesRotting(int** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int freshCount = 0, minutes = 0;
    int queue[1000][2], front = 0, rear = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] == 1) freshCount++;
            if (grid[i][j] == 2) {
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
                if (newX >= 0 && newX < gridSize && newY >= 0 && newY < *gridColSize && grid[newX][newY] == 1) {
                    grid[newX][newY] = 2;
                    freshCount--;
                    queue[rear][0] = newX;
                    queue[rear][1] = newY;
                    rear++;
                }
            }
        }
        if (front < rear) minutes++;
    }

    return freshCount == 0 ? minutes : -1;
}