#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    int *x = *(int **)a;
    int *y = *(int **)b;
    if (x[0] != y[0]) {
        return y[0] - x[0];
    } else {
        return x[1] - y[1];
    }
}

int numberOfWeakCharacters(int** properties, int propertiesSize, int* propertiesColSize){
    qsort(properties, propertiesSize, sizeof(properties[0]), compare);
    int maxDefense = 0;
    int weakCharacters = 0;
    for (int i = 0; i < propertiesSize; i++) {
        if (properties[i][1] < maxDefense) {
            weakCharacters++;
        } else {
            maxDefense = properties[i][1];
        }
    }
    return weakCharacters;
}