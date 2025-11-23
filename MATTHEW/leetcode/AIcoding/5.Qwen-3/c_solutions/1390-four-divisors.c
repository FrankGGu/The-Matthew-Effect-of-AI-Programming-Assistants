#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int* fourDivisors(int* nums, int numsSize, int* returnSize) {
    int* result = NULL;
    int resultSize = 0;
    int capacity = 0;

    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        int count = 0;
        int sum = 0;
        int sqrtN = (int)sqrt(n);

        for (int j = 1; j <= sqrtN; j++) {
            if (n % j == 0) {
                count++;
                if (j * j != n) {
                    count++;
                }
            }
        }

        if (count == 4) {
            int temp = 0;
            for (int j = 1; j <= sqrtN; j++) {
                if (n % j == 0) {
                    temp += j;
                    if (j * j != n) {
                        temp += n / j;
                    }
                }
            }
            if (resultSize + 1 > capacity) {
                capacity = (capacity == 0) ? 1 : capacity * 2;
                result = (int*)realloc(result, capacity * sizeof(int));
            }
            result[resultSize++] = temp;
        }
    }

    *returnSize = resultSize;
    return result;
}