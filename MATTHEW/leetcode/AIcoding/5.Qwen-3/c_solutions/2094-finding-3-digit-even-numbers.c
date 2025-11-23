#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findEvenNumbers(int* digits, int digitsSize, int* returnSize) {
    int* result = NULL;
    int resultCapacity = 0;
    int resultSize = 0;

    for (int i = 0; i < digitsSize; i++) {
        for (int j = 0; j < digitsSize; j++) {
            if (i == j) continue;
            for (int k = 0; k < digitsSize; k++) {
                if (i == k || j == k) continue;
                if (digits[k] % 2 == 0) {
                    int num = digits[i] * 100 + digits[j] * 10 + digits[k];
                    int found = 0;
                    for (int m = 0; m < resultSize; m++) {
                        if (result[m] == num) {
                            found = 1;
                            break;
                        }
                    }
                    if (!found) {
                        if (resultSize >= resultCapacity) {
                            resultCapacity = (resultCapacity == 0) ? 1 : resultCapacity * 2;
                            result = (int*)realloc(result, resultCapacity * sizeof(int));
                        }
                        result[resultSize++] = num;
                    }
                }
            }
        }
    }

    *returnSize = resultSize;
    return result;
}