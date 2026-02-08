#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheIntegerAddedToArray(int* array, int arraySize, int d) {
    int sum = 0;
    for (int i = 0; i < arraySize; i++) {
        sum += array[i];
    }

    if (sum % (arraySize + 1) == 0) {
        return d - (sum / (arraySize + 1));
    } else {
        return d - (sum / (arraySize + 1));
    }
}