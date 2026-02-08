#include <stdlib.h>

int isSelfDividing(int num) {
    int temp = num;
    while (temp > 0) {
        int digit = temp % 10;
        if (digit == 0 || num % digit != 0) {
            return 0;
        }
        temp /= 10;
    }
    return 1;
}

int* selfDividingNumbers(int left, int right, int* returnSize) {
    int* result_temp = (int*)malloc(sizeof(int) * (right - left + 1));
    if (result_temp == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int count = 0;
    for (int i = left; i <= right; i++) {
        if (isSelfDividing(i)) {
            result_temp[count++] = i;
        }
    }

    int* final_result = (int*)malloc(sizeof(int) * count);
    if (final_result == NULL) {
        free(result_temp);
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < count; i++) {
        final_result[i] = result_temp[i];
    }

    free(result_temp);

    *returnSize = count;
    return final_result;
}