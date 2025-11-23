#include <stdlib.h>

int* findErrorNums(int* nums, int numsSize, int* returnSize) {
    long long n = numsSize;

    long long sum_actual = n * (n + 1) / 2;
    long long sum_squares_actual = n * (n + 1) * (2 * n + 1) / 6;

    long long sum_nums = 0;
    long long sum_squares_nums = 0;

    for (int i = 0; i < n; i++) {
        sum_nums += nums[i];
        sum_squares_nums += (long long)nums[i] * nums[i];
    }

    long long diff_R_M = sum_nums - sum_actual;
    long long sum_R_M = (sum_squares_nums - sum_squares_actual) / diff_R_M;

    int repeated = (int)((diff_R_M + sum_R_M) / 2);
    int missing = (int)((sum_R_M - diff_R_M) / 2);

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = repeated;
    result[1] = missing;

    *returnSize = 2;
    return result;
}