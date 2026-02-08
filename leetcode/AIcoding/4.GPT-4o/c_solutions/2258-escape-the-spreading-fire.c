int canEscape(char **forest, int forestSize, int *forestColSize) {
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int fire[forestSize][*forestColSize];
    memset(fire, -1, sizeof(fire));
    int queue[forestSize * (*forestColSize)][2];
    int front = 0, rear = 0;

    for (int i = 0; i < forestSize; i++) {
        for (int j = 0; j < *forestColSize; j++) {
            if (forest[i][j] == 'F') {
                queue[rear][0] = i;
                queue[rear][1] = j;
                fire[i][j] = 0;
                rear++;
            }
        }
    }

    while (front < rear) {
        int x = queue[front][0];
        int y = queue[front][1];
        front++;
        for (int k = 0; k < 4; k++) {
            int newX = x + directions[k][0];
            int newY = y + directions[k][1];
            if (newX >= 0 && newY >= 0 && newX < forestSize && newY < *forestColSize && fire[newX][newY] == -1 && forest[newX][newY] != '#') {
                fire[newX][newY] = fire[x][y] + 1;
                queue[rear][0] = newX;
                queue[rear][1] = newY;
                rear++;
            }
        }
    }

    int startX, startY, exitX, exitY;
    for (int i = 0; i < forestSize; i++) {
        for (int j = 0; j < *forestColSize; j++) {
            if (forest[i][j] == 'S') {
                startX = i;
                startY = j;
            } else if (forest[i][j] == 'E') {
                exitX = i;
                exitY = j;
            }
        }
    }

    int steps = 0;
    int visited[forestSize][*forestColSize];
    memset(visited, 0, sizeof(visited));
    queue[0][0] = startX;
    queue[0][1] = startY;
    rear = 1;

    while (front < rear) {
        int size = rear - front;
        steps++;
        for (int i = 0; i < size; i++) {
            int x = queue[front][0];
            int y = queue[front][1];
            front++;
            for (int k = 0; k < 4; k++) {
                int newX = x + directions[k][0];
                int newY = y + directions[k][1];
                if (newX == exitX && newY == exitY) {
                    return steps;
                }
                if (newX >= 0 && newY >= 0 && newX < forestSize && newY < *forestColSize && forest[newX][newY] != '#' && !visited[newX][newY]) {
                    visited[newX][newY] = 1;
                    if (fire[newX][newY] == -1 || fire[newX][newY] > steps) {
                        queue[rear][0] = newX;
                        queue[rear][1] = newY;
                        rear++;
                    }
                }
            }
        }
    }

    return -1;
}