#include <stdio.h>
#include <stdlib.h>

int** reconstructQueue(int** people, int peopleSize, int* peopleColSize, int* returnSize) {
    int** result = (int**)malloc(peopleSize * sizeof(int*));
    for (int i = 0; i < peopleSize; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
    }

    for (int i = 0; i < peopleSize; i++) {
        result[i][0] = people[i][0];
        result[i][1] = people[i][1];
    }

    for (int i = 0; i < peopleSize; i++) {
        for (int j = 0; j < peopleSize - 1; j++) {
            if (result[j][0] < result[j + 1][0] || 
                (result[j][0] == result[j + 1][0] && result[j][1] > result[j + 1][1])) {
                int* temp = result[j];
                result[j] = result[j + 1];
                result[j + 1] = temp;
            }
        }
    }

    *returnSize = peopleSize;
    return result;
}