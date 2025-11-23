#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getRow(int rowIndex, int* returnSize) {
    *returnSize = rowIndex + 1;
    int* row = (int*)malloc(sizeof(int) * (*returnSize));
    row[0] = 1;
    for (int i = 1; i <= rowIndex; i++) {
        for (int j = i; j > 0; j--) {
            if (j == i) {
                row[j] = 1;
            } else {
                row[j] = row[j] + row[j - 1];
            }
        }
    }
    return row;
}