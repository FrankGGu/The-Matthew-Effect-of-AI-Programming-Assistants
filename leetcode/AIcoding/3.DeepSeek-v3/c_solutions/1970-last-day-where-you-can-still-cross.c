int latestDayToCross(int row, int col, int** cells, int cellsSize, int* cellsColSize) {
    int left = 0, right = cellsSize - 1;
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    while (left <= right) {
        int mid = left + (right - left) / 2;

        int grid[row + 1][col + 1];
        for (int i = 1; i <= row; i++) {
            for (int j = 1; j <= col; j++) {
                grid[i][j] = 0;
            }
        }

        for (int i = 0; i <= mid; i++) {
            grid[cells[i][0]][cells[i][1]] = 1;
        }

        int queue[row * col][2];
        int front = 0, rear = 0;

        for (int j = 1; j <= col; j++) {
            if (grid[1][j] == 0) {
                queue[rear][0] = 1;
                queue[rear][1] = j;
                rear++;
                grid[1][j] = 1;
            }
        }

        int found = 0;
        while (front < rear) {
            int r = queue[front][0];
            int c = queue[front][1];
            front++;

            if (r == row) {
                found = 1;
                break;
            }

            for (int i = 0; i < 4; i++) {
                int nr = r + directions[i][0];
                int nc = c + directions[i][1];

                if (nr >= 1 && nr <= row && nc >= 1 && nc <= col && grid[nr][nc] == 0) {
                    grid[nr][nc] = 1;
                    queue[rear][0] = nr;
                    queue[rear][1] = nc;
                    rear++;
                }
            }
        }

        if (found) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return left;
}