#include <stdio.h>
#include <stdlib.h>

int minAreaRect(int** image, int imageSize, int* imageColSize) {
    int rows = imageSize;
    int cols = imageColSize[0];
    int* ones = (int*)malloc(rows * cols * sizeof(int));
    int count = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (image[i][j] == 1) {
                ones[count++] = i * cols + j;
            }
        }
    }

    if (count < 4) return 0;

    int minArea = INT_MAX;
    for (int i = 0; i < count; i++) {
        int x1 = ones[i] / cols;
        int y1 = ones[i] % cols;
        for (int j = i + 1; j < count; j++) {
            int x2 = ones[j] / cols;
            int y2 = ones[j] % cols;
            if (x1 != x2 && y1 != y2) {
                int x3 = x1, y3 = y2;
                int x4 = x2, y4 = y1;
                int found = 0;
                for (int k = 0; k < count; k++) {
                    if (ones[k] == x3 * cols + y3 || ones[k] == x4 * cols + y4) {
                        found++;
                        if (found == 2) break;
                    }
                }
                if (found == 2) {
                    int area = abs(x1 - x2) * abs(y1 - y2);
                    if (area < minArea) minArea = area;
                }
            }
        }
    }

    free(ones);
    return minArea;
}