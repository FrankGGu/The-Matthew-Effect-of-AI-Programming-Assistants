int orangesRotting(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int queue[rows * cols][2];
    int front = 0, rear = 0;
    int fresh = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 2) {
                queue[rear][0] = i;
                queue[rear][1] = j;
                rear++;
            } else if (grid[i][j] == 1) {
                fresh++;
            }
        }
    }

    if (fresh == 0) return 0;

    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    int minutes = -1;

    while (front < rear) {
        int size = rear - front;
        minutes++;

        for (int i = 0; i < size; i++) {
            int r = queue[front][0];
            int c = queue[front][1];
            front++;

            for (int d = 0; d < 4; d++) {
                int nr = r + directions[d][0];
                int nc = c + directions[d][1];

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc] == 1) {
                    grid[nr][nc] = 2;
                    fresh--;
                    queue[rear][0] = nr;
                    queue[rear][1] = nc;
                    rear++;
                }
            }
        }
    }

    return fresh == 0 ? minutes : -1;
}