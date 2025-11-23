int dx[8] = {2, 2, -2, -2, 1, 1, -1, -1};
int dy[8] = {1, -1, 1, -1, 2, -2, 2, -2};

int minMovesToCaptureTheQueen(int a, int b, int c, int d, int e, int f) {
    if (a == e && b == f) return 0;

    int board[9][9];
    for (int i = 1; i <= 8; i++) {
        for (int j = 1; j <= 8; j++) {
            board[i][j] = -1;
        }
    }

    board[a][b] = 0;
    int queue[65][2];
    int front = 0, rear = 0;
    queue[rear][0] = a;
    queue[rear][1] = b;
    rear++;

    while (front < rear) {
        int x = queue[front][0];
        int y = queue[front][1];
        front++;

        for (int i = 0; i < 8; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= 1 && nx <= 8 && ny >= 1 && ny <= 8 && board[nx][ny] == -1) {
                if (nx == c && ny == d) continue;

                if ((nx == c && y == d) || (ny == d && x == c)) continue;

                if (nx == e && ny == f) {
                    return board[x][y] + 1;
                }

                board[nx][ny] = board[x][y] + 1;
                queue[rear][0] = nx;
                queue[rear][1] = ny;
                rear++;
            }
        }
    }

    return -1;
}