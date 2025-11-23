#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestOverlap(int** img1, int img1Size, int* img1ColSize, int** img2, int img2Size, int* img2ColSize) {
    int n = img1Size;
    int max_overlap = 0;

    for (int x_shift = -n + 1; x_shift < n; x_shift++) {
        for (int y_shift = -n + 1; y_shift < n; y_shift++) {
            int overlap = 0;
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    int shifted_i = i + x_shift;
                    int shifted_j = j + y_shift;

                    if (shifted_i >= 0 && shifted_i < n && shifted_j >= 0 && shifted_j < n) {
                        if (img1[i][j] == 1 && img2[shifted_i][shifted_j] == 1) {
                            overlap++;
                        }
                    }
                }
            }
            if (overlap > max_overlap) {
                max_overlap = overlap;
            }
        }
    }

    return max_overlap;
}