#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* threeEqualParts(int* arr, int arrSize, int* returnSize) {
    int totalOnes = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == 1) totalOnes++;
    }

    if (totalOnes % 3 != 0) {
        *returnSize = 0;
        return NULL;
    }

    if (totalOnes == 0) {
        *returnSize = 2;
        int* result = (int*)malloc(2 * sizeof(int));
        result[0] = 0;
        result[1] = 1;
        return result;
    }

    int partSize = totalOnes / 3;
    int first = -1, second = -1, third = -1;
    int count = 0;

    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == 1) {
            count++;
            if (count == partSize && first == -1) first = i;
            else if (count == 2 * partSize && second == -1) second = i;
            else if (count == 3 * partSize && third == -1) third = i;
        }
    }

    int len = arrSize - third;
    if (first + len > second || second + len > third) {
        *returnSize = 0;
        return NULL;
    }

    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = first + len - 1;
    result[1] = second + len - 1;
    return result;
}