#include <stdio.h>
#include <stdlib.h>

int** imageOverlap(int** img1, int img1Size, int* img1ColSize, int** img2, int img2Size, int* img2ColSize, int* returnSize, int** returnColumnSizes) {
    int n = img1Size;
    int* translations = (int*)malloc(sizeof(int) * 4 * n * n);
    int count = 0;

    for (int i1 = 0; i1 < n; i1++) {
        for (int j1 = 0; j1 < n; j1++) {
            if (img1[i1][j1] == 1) {
                for (int i2 = 0; i2 < n; i2++) {
                    for (int j2 = 0; j2 < n; j2++) {
                        if (img2[i2][j2] == 1) {
                            translations[count++] = (i1 - i2) * n + (j1 - j2);
                        }
                    }
                }
            }
        }
    }

    int* freq = (int*)calloc(4 * n * n, sizeof(int));
    int max = 0;

    for (int i = 0; i < count; i++) {
        freq[translations[i]]++;
        if (freq[translations[i]] > max) {
            max = freq[translations[i]];
        }
    }

    *returnSize = max;
    *returnColumnSizes = (int*)malloc(sizeof(int) * max);

    int k = 0;
    for (int i = 0; i < 4 * n * n; i++) {
        if (freq[i] == max) {
            (*returnColumnSizes)[k++] = i;
        }
    }

    free(translations);
    free(freq);

    return NULL;
}