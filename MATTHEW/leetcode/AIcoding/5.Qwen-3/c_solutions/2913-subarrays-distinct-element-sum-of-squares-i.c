#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumDistinctSquares(int* array, int arraySize) {
    int result = 0;
    for (int i = 0; i < arraySize; i++) {
        int count[1001] = {0};
        int unique = 0;
        for (int j = i; j < arraySize; j++) {
            if (count[array[j]] == 0) {
                unique++;
            }
            count[array[j]]++;
            result += unique * unique;
        }
    }
    return result;
}