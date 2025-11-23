#define MAX 100

typedef struct {
    int x, y, dist;
} Point;

int nearestExit(char **maze, int mazeSize, int *mazeColSize, int entranceRow, int entranceCol) {
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int queue[MAX * MAX][2], front = 0, rear = 0;
    int visited[MAX][MAX] = {0};

    queue[rear][0] = entranceRow;
    queue[rear][1] = entranceCol;
    rear++;
    visited[entranceRow][entranceCol] = 1;

    while (front < rear) {
        Point p = {queue[front][0], queue[front][1], front};
        front++;

        if ((p.x != entranceRow || p.y != entranceCol) && (p.x == 0 || p.x == mazeSize - 1 || p.y == 0 || p.y == (*mazeColSize) - 1)) {
            return p.dist;
        }

        for (int i = 0; i < 4; i++) {
            int newX = p.x + directions[i][0];
            int newY = p.y + directions[i][1];

            if (newX >= 0 && newX < mazeSize && newY >= 0 && newY < *mazeColSize && !visited[newX][newY] && maze[newX][newY] == '.') {
                visited[newX][newY] = 1;
                queue[rear][0] = newX;
                queue[rear][1] = newY;
                rear++;
            }
        }
    }

    return -1;
}