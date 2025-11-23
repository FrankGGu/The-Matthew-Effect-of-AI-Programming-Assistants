#include <stdio.h>
#include <stdlib.h>

int maximumWidthRamp(int* A, int ASize) {
    int* indices = (int*)malloc(ASize * sizeof(int));
    for (int i = 0; i < ASize; i++) {
        indices[i] = i;
    }

    for (int i = 0; i < ASize - 1; i++) {
        for (int j = i + 1; j < ASize; j++) {
            if (A[indices[i]] <= A[indices[j]]) {
                int temp = indices[i];
                indices[i] = indices[j];
                indices[j] = temp;
            }
        }
    }

    int max_width = 0;
    for (int i = 0; i < ASize; i++) {
        for (int j = i + 1; j < ASize; j++) {
            if (A[indices[i]] <= A[indices[j]]) {
                max_width = (indices[j] - indices[i] > max_width) ? (indices[j] - indices[i]) : max_width;
                break;
            }
        }
    }

    free(indices);
    return max_width;
}