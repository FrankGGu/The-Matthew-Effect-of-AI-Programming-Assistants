bool canEscape(int** maze, int mazeSize, int* mazeColSize, int* entrance, int* exit) {
    int rows = mazeSize;
    int cols = mazeColSize[0];
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    bool visited[rows][cols];
    memset(visited, 0, sizeof(visited));

    int startX = entrance[0], startY = entrance[1];
    int exitX = exit[0], exitY = exit[1];

    if (startX == exitX && startY == exitY) {
        return true;
    }

    visited[startX][startY] = true;
    int queueSize = rows * cols;
    int front = 0, back = 0;
    int* queue = (int*)malloc(queueSize * 2 * sizeof(int));
    queue[back++] = startX;
    queue[back++] = startY;

    while (front < back) {
        int x = queue[front++];
        int y = queue[front++];

        for (int i = 0; i < 4; i++) {
            int newX = x, newY = y;
            while (newX + directions[i][0] >= 0 && newX + directions[i][0] < rows &&
                   newY + directions[i][1] >= 0 && newY + directions[i][1] < cols &&
                   maze[newX + directions[i][0]][newY + directions[i][1]] == 0) {
                newX += directions[i][0];
                newY += directions[i][1];
            }

            if (newX == exitX && newY == exitY) {
                free(queue);
                return true;
            }

            if (!visited[newX][newY]) {
                visited[newX][newY] = true;
                queue[back++] = newX;
                queue[back++] = newY;
            }
        }
    }

    free(queue);
    return false;
}