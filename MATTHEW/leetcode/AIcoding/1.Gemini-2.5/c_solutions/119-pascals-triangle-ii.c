#include <stdlib.h>

int* getRow(int rowIndex, int* returnSize) {
    *returnSize = rowIndex + 1;
    int* row = (int*) malloc(sizeof(int) * (*returnSize));

    row[0] = 1;

    for (int i = 1; i <= rowIndex; i++) {
        row[i] = 1;
        for (int j = i - 1; j >= 1; j--) {
            row[j] = row[j] + row[j - 1];
        }
    }

    return row;
}