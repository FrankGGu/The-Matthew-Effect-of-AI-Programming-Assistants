int digitSum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int wardrobeFinishing(int m, int n, int cnt) {
    if (cnt < 0) return 0;

    int result = 0;
    int visited[m][n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            visited[i][j] = 0;
        }
    }

    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int queue[m * n][2];
    int front = 0, rear = 0;

    if (digitSum(0) + digitSum(0) <= cnt) {
        queue[rear][0] = 0;
        queue[rear][1] = 0;
        rear++;
        visited[0][0] = 1;
        result++;
    }

    while (front < rear) {
        int x = queue[front][0];
        int y = queue[front][1];
        front++;

        for (int i = 0; i < 4; i++) {
            int nx = x + directions[i][0];
            int ny = y + directions[i][1];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                if (digitSum(nx) + digitSum(ny) <= cnt) {
                    queue[rear][0] = nx;
                    queue[rear][1] = ny;
                    rear++;
                    visited[nx][ny] = 1;
                    result++;
                }
            }
        }
    }

    return result;
}