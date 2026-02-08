#include <stdio.h>
#include <stdlib.h>

int** reconstructMatrix(int n, int k, int* row1, int row1Size, int* row2, int row2Size) {
    int** result = (int**)malloc(2 * sizeof(int*));
    result[0] = (int*)malloc(n * sizeof(int));
    result[1] = (int*)malloc(n * sizeof(int));

    int count1 = 0, count2 = 0;
    for (int i = 0; i < n; i++) {
        if (row1[i] == 1) {
            count1++;
        }
        if (row2[i] == 1) {
            count2++;
        }
    }

    if (count1 != row1Size || count2 != row2Size) {
        free(result[0]);
        free(result[1]);
        free(result);
        return NULL;
    }

    for (int i = 0; i < n; i++) {
        result[0][i] = row1[i];
        result[1][i] = row2[i];
    }

    return result;
}