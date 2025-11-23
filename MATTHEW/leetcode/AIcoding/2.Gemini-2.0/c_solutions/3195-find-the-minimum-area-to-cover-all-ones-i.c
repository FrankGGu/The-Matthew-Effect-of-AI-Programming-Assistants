#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minArea(char** image, int imageSize, int* imageColSize, int row, int col) {
    int min_row = imageSize, max_row = -1, min_col = *imageColSize, max_col = -1;

    for (int i = 0; i < imageSize; i++) {
        for (int j = 0; j < *imageColSize; j++) {
            if (image[i][j] == '1') {
                min_row = (min_row < i) ? min_row : i;
                max_row = (max_row > i) ? max_row : i;
                min_col = (min_col < j) ? min_col : j;
                max_col = (max_col > j) ? max_col : j;
            }
        }
    }

    return (max_row - min_row + 1) * (max_col - min_col + 1);
}