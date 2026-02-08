#include <stdlib.h>
#include <stdbool.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool* checkArithmeticSubarrays(int* nums, int numsSize, int* l, int lSize, int* r, int rSize, int* returnSize) {
    *returnSize = lSize;
    bool* result = (bool*) malloc(sizeof(bool) * lSize);

    for (int i = 0; i < lSize; i++) {
        int left = l[i];
        int right = r[i];
        int len = right - left + 1;

        if (len <= 2) {
            result[i] = true;
            continue;
        }

        int temp_arr[len];
        for (int k = 0; k < len; k++) {
            temp_arr[k] = nums[left + k];
        }

        qsort(temp_arr, len, sizeof(int), compare);

        int diff = temp_arr[1] - temp_arr[0];
        bool is_arithmetic = true;
        for (int k = 2; k < len; k++) {
            if (temp_arr[k] - temp_arr[k-1] != diff) {
                is_arithmetic = false;
                break;
            }
        }
        result[i] = is_arithmetic;
    }

    return result;
}