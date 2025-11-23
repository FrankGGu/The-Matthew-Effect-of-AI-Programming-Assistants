#include <stdio.h>
#include <stdlib.h>

int** floodFill(int** image, int imageSize, int* imageColSize, int sr, int sc, int newColor) {
    int originalColor = image[sr][sc];
    if (originalColor == newColor) {
        return image;
    }

    int rows = imageSize;
    int cols = imageColSize[0];

    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            result[i][j] = image[i][j];
        }
    }

    int* queue = (int*)malloc(rows * cols * 2 * sizeof(int));
    int front = 0, rear = 0;

    queue[rear++] = sr;
    queue[rear++] = sc;

    while (front < rear) {
        int r = queue[front++];
        int c = queue[front++];

        result[r][c] = newColor;

        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (int i = 0; i < 4; i++) {
            int nr = r + directions[i][0];
            int nc = c + directions[i][1];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && result[nr][nc] == originalColor) {
                queue[rear++] = nr;
                queue[rear++] = nc;
            }
        }
    }

    free(queue);
    return result;
}