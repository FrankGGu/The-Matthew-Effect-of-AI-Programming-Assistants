#include <stdlib.h>
#include <string.h>

int* separateDigits(int* nums, int numsSize, int* returnSize) {
    int capacity = 10000; 
    int* result = (int*)malloc(capacity * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num == 0) {
            if (*returnSize >= capacity) {
                capacity *= 2;
                result = (int*)realloc(result, capacity * sizeof(int));
            }
            result[(*returnSize)++] = 0;
            continue;
        }

        int temp_num = num;
        int num_digits = 0;
        while (temp_num > 0) {
            temp_num /= 10;
            num_digits++;
        }

        if (*returnSize + num_digits > capacity) {
            capacity = (*returnSize + num_digits) * 2; 
            result = (int*)realloc(result, capacity * sizeof(int));
        }

        int current_idx = *returnSize + num_digits - 1;
        while (num > 0) {
            result[current_idx--] = num % 10;
            num /= 10;
        }
        *returnSize += num_digits;
    }

    return result;
}