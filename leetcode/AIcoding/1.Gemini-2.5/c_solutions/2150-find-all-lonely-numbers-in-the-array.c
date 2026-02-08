#include <stdlib.h>
#include <string.h>

#define MAX_VAL 1000000

int* findLonely(int* nums, int numsSize, int* returnSize) {
    int* freq = (int*)calloc(MAX_VAL + 1, sizeof(int));
    if (freq == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int* result = NULL;
    int resultCapacity = 10;
    *returnSize = 0;
    result = (int*)malloc(resultCapacity * sizeof(int));
    if (result == NULL) {
        free(freq);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i <= MAX_VAL; i++) {
        if (freq[i] == 1) {
            int isLonely = 1;

            if (i > 0 && freq[i - 1] > 0) {
                isLonely = 0;
            }

            if (isLonely && i < MAX_VAL && freq[i + 1] > 0) {
                isLonely = 0;
            }

            if (isLonely) {
                if (*returnSize == resultCapacity) {
                    resultCapacity *= 2;
                    int* newResult = (int*)realloc(result, resultCapacity * sizeof(int));
                    if (newResult == NULL) {
                        free(result);
                        free(freq);
                        *returnSize = 0;
                        return NULL;
                    }
                    result = newResult;
                }
                result[*returnSize] = i;
                (*returnSize)++;
            }
        }
    }

    free(freq);
    return result;
}