int minSteps(char** grid, int gridSize, int* gridColSize) {
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int startX, startY, endX, endY;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == 'S') {
                startX = i;
                startY = j;
            } else if (grid[i][j] == 'E') {
                endX = i;
                endY = j;
            }
        }
    }

    int queue[gridSize * gridColSize[0]][2];
    int front = 0, rear = 0;
    int visited[gridSize][gridColSize[0]];
    memset(visited, 0, sizeof(visited));

    queue[rear][0] = startX;
    queue[rear][1] = startY;
    rear++;
    visited[startX][startY] = 1;

    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            int x = queue[front][0];
            int y = queue[front][1];
            front++;

            if (x == endX && y == endY) {
                return steps;
            }

            for (int j = 0; j < 4; j++) {
                int newX = x + directions[j][0];
                int newY = y + directions[j][1];

                if (newX >= 0 && newX < gridSize && newY >= 0 && newY < gridColSize[newX] && 
                    grid[newX][newY] != '#' && !visited[newX][newY]) {
                    queue[rear][0] = newX;
                    queue[rear][1] = newY;
                    rear++;
                    visited[newX][newY] = 1;
                }
            }
        }
        steps++;
    }

    return -1;
}