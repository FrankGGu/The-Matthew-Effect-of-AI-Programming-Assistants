#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int subarrayBitwiseORs(int* arr, int arrSize, int* returnSize) {
    int* distinctORs = (int*)malloc(arrSize * arrSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < arrSize; i++) {
        int currentOR = 0;
        for (int j = i; j < arrSize; j++) {
            currentOR |= arr[j];

            int found = 0;
            for (int k = 0; k < count; k++) {
                if (distinctORs[k] == currentOR) {
                    found = 1;
                    break;
                }
            }

            if (!found) {
                distinctORs[count] = currentOR;
                count++;
            }
        }
    }

    *returnSize = count;

    int* result = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        result[i] = distinctORs[i];
    }

    free(distinctORs);
    return result;
}