typedef struct {
    int x;
    int y;
    int steps;
} Point;

int nearestExit(char** maze, int mazeSize, int* mazeColSize, int* entrance, int entranceSize) {
    int rows = mazeSize;
    int cols = mazeColSize[0];
    int dirs[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    Point* queue = (Point*)malloc(rows * cols * sizeof(Point));
    int front = 0, rear = 0;

    bool** visited = (bool**)malloc(rows * sizeof(bool*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool*)calloc(cols, sizeof(bool));
    }

    queue[rear++] = (Point){entrance[0], entrance[1], 0};
    visited[entrance[0]][entrance[1]] = true;

    while (front < rear) {
        Point current = queue[front++];

        for (int i = 0; i < 4; i++) {
            int nx = current.x + dirs[i][0];
            int ny = current.y + dirs[i][1];

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && 
                maze[nx][ny] == '.' && !visited[nx][ny]) {

                if (nx == 0 || nx == rows - 1 || ny == 0 || ny == cols - 1) {
                    if (nx != entrance[0] || ny != entrance[1]) {
                        free(queue);
                        for (int i = 0; i < rows; i++) free(visited[i]);
                        free(visited);
                        return current.steps + 1;
                    }
                }

                visited[nx][ny] = true;
                queue[rear++] = (Point){nx, ny, current.steps + 1};
            }
        }
    }

    free(queue);
    for (int i = 0; i < rows; i++) free(visited[i]);
    free(visited);
    return -1;
}