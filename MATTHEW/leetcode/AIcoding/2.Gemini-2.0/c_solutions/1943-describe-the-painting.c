#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
    int color;
} Interval;

int compare(const void *a, const void *b) {
    return ((Interval*)a)->start - ((Interval*)b)->start;
}

int** describeThePainting(int** segments, int segmentsSize, int* segmentsColSize, int* returnSize, int** returnColumnSizes) {
    int i, j, k;
    int maxEnd = 0;
    for (i = 0; i < segmentsSize; i++) {
        if (segments[i][1] > maxEnd) {
            maxEnd = segments[i][1];
        }
    }

    int* color = (int*)calloc(maxEnd + 1, sizeof(int));
    for (i = 0; i < segmentsSize; i++) {
        for (j = segments[i][0]; j < segments[i][1]; j++) {
            color[j] += segments[i][2];
        }
    }

    int count = 0;
    for (i = 0; i < maxEnd; i++) {
        if (color[i] > 0) {
            count++;
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = 0;

    int start = 0;
    int currentColor = 0;
    for (i = 0; i < maxEnd; i++) {
        if (color[i] > 0) {
            if (currentColor == 0) {
                start = i;
                currentColor = color[i];
            } else if (color[i] != currentColor) {
                result[*returnSize] = (int*)malloc(3 * sizeof(int));
                result[*returnSize][0] = start;
                result[*returnSize][1] = i;
                result[*returnSize][2] = currentColor;
                (*returnColumnSizes)[*returnSize] = 3;
                (*returnSize)++;
                start = i;
                currentColor = color[i];
            }
        } else {
            if (currentColor > 0) {
                result[*returnSize] = (int*)malloc(3 * sizeof(int));
                result[*returnSize][0] = start;
                result[*returnSize][1] = i;
                result[*returnSize][2] = currentColor;
                (*returnColumnSizes)[*returnSize] = 3;
                (*returnSize)++;
                currentColor = 0;
            }
        }
    }
    if (currentColor > 0) {
        result[*returnSize] = (int*)malloc(3 * sizeof(int));
        result[*returnSize][0] = start;
        result[*returnSize][1] = maxEnd;
        result[*returnSize][2] = currentColor;
        (*returnColumnSizes)[*returnSize] = 3;
        (*returnSize)++;
    }

    free(color);

    return result;
}