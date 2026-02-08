#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[0] != y[0]) {
        return y[0] - x[0];
    } else {
        return y[1] - x[1];
    }
}

int numberOfWeakCharacters(int** properties, int propertiesSize, int* propertiesColSize) {
    qsort(properties, propertiesSize, sizeof(int*), compare);
    int count = 0;
    int max = 0;
    for (int i = 0; i < propertiesSize; i++) {
        if (properties[i][1] < max) {
            count++;
        } else {
            max = properties[i][1];
        }
    }
    return count;
}