#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* threeEqualParts(int* arr, int arrSize, int* returnSize) {
    int ones = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == 1) {
            ones++;
        }
    }

    if (ones % 3 != 0) {
        *returnSize = 2;
        int* result = (int*)malloc(2 * sizeof(int));
        result[0] = -1;
        result[1] = -1;
        return result;
    }

    if (ones == 0) {
        *returnSize = 2;
        int* result = (int*)malloc(2 * sizeof(int));
        result[0] = 0;
        result[1] = arrSize - 1;
        return result;
    }

    int onesPerPart = ones / 3;
    int firstPartEnd = -1, secondPartEnd = -1, thirdPartEnd = -1;
    int currentOnes = 0;

    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == 1) {
            currentOnes++;
            if (currentOnes == onesPerPart) {
                firstPartEnd = i;
                break;
            }
        }
    }

    for (int i = firstPartEnd + 1; i < arrSize; i++) {
        if (arr[i] == 1) {
            currentOnes++;
            if (currentOnes == 2 * onesPerPart) {
                secondPartEnd = i;
                break;
            }
        }
    }

    for (int i = secondPartEnd + 1; i < arrSize; i++) {
        if (arr[i] == 1) {
            currentOnes++;
            if (currentOnes == ones) {
                thirdPartEnd = i;
                break;
            }
        }
    }

    int firstPartStart = -1, secondPartStart = -1, thirdPartStart = -1;
    currentOnes = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] == 1) {
            if (currentOnes == 0) {
                firstPartStart = i;
            }
            currentOnes++;
            if (currentOnes == onesPerPart) break;
        }
    }

    currentOnes = onesPerPart;
    for (int i = firstPartEnd + 1; i < arrSize; i++) {
        if (arr[i] == 1) {
            if (currentOnes == onesPerPart) {
                secondPartStart = i;
            }
            currentOnes++;
            if (currentOnes == 2 * onesPerPart) break;
        }
    }

    currentOnes = 2 * onesPerPart;
    for (int i = secondPartEnd + 1; i < arrSize; i++) {
        if (arr[i] == 1) {
            if (currentOnes == 2 * onesPerPart) {
                thirdPartStart = i;
            }
            currentOnes++;
            if (currentOnes == ones) break;
        }
    }

    int len = thirdPartEnd - thirdPartStart + 1;
    int i = 0;
    while (i < len) {
        if (arr[firstPartStart + i] != arr[secondPartStart + i] || arr[firstPartStart + i] != arr[thirdPartStart + i]) {
            *returnSize = 2;
            int* result = (int*)malloc(2 * sizeof(int));
            result[0] = -1;
            result[1] = -1;
            return result;
        }
        i++;
    }

    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = firstPartEnd + (thirdPartStart - secondPartStart);
    result[1] = secondPartEnd + (thirdPartStart - secondPartStart) + 1;
    return result;
}