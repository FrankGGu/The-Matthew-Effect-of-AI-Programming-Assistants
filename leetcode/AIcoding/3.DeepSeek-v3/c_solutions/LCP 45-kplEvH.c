/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int** bicycleYard(int* position, int positionSize, int** terrain, int terrainSize, int* terrainColSize, int** obstacle, int obstacleSize, int* obstacleColSize, int* returnSize, int** returnColumnSizes) {
    int m = terrainSize, n = terrainColSize[0];
    int dx[4] = {0, 0, 1, -1};
    int dy[4] = {1, -1, 0, 0};

    int*** visited = (int***)malloc(m * sizeof(int**));
    for (int i = 0; i < m; i++) {
        visited[i] = (int**)malloc(n * sizeof(int*));
        for (int j = 0; j < n; j++) {
            visited[i][j] = (int*)calloc(102, sizeof(int));
        }
    }

    int** result = (int**)malloc(m * n * sizeof(int*));
    int count = 0;

    int start_x = position[0], start_y = position[1];
    visited[start_x][start_y][1] = 1;

    int queue[30000][3];
    int front = 0, rear = 0;
    queue[rear][0] = start_x;
    queue[rear][1] = start_y;
    queue[rear][2] = 1;
    rear++;

    while (front < rear) {
        int x = queue[front][0];
        int y = queue[front][1];
        int speed = queue[front][2];
        front++;

        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];
            if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;

            int new_speed = speed + (terrain[x][y] - terrain[nx][ny] - obstacle[nx][ny]);
            if (new_speed <= 0) continue;
            if (new_speed > 100) continue;

            if (!visited[nx][ny][new_speed]) {
                visited[nx][ny][new_speed] = 1;
                queue[rear][0] = nx;
                queue[rear][1] = ny;
                queue[rear][2] = new_speed;
                rear++;
            }
        }
    }

    visited[start_x][start_y][1] = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (visited[i][j][1]) {
                result[count] = (int*)malloc(2 * sizeof(int));
                result[count][0] = i;
                result[count][1] = j;
                count++;
            }
        }
    }

    *returnSize = count;
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            free(visited[i][j]);
        }
        free(visited[i]);
    }
    free(visited);

    return result;
}