#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef long long ll;

int* findValidSplit(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 0;

    if (numsSize == 1) {
        result[0] = -1;
        *returnSize = 1;
        return result;
    }

    int max_num = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_num) max_num = nums[i];
    }

    int* prime_count = (int*)calloc(max_num + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        for (int p = 2; p * p <= n; p++) {
            while (n % p == 0) {
                prime_count[p]++;
                n /= p;
            }
        }
        if (n > 1) prime_count[n]++;
    }

    int* left_prime_count = (int*)calloc(max_num + 1, sizeof(int));
    int* right_prime_count = (int*)calloc(max_num + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        int n = nums[i];
        for (int p = 2; p * p <= n; p++) {
            while (n % p == 0) {
                right_prime_count[p]++;
                n /= p;
            }
        }
        if (n > 1) right_prime_count[n]++;
    }

    int idx = -1;
    for (int i = 0; i < numsSize - 1; i++) {
        int n = nums[i];
        for (int p = 2; p * p <= n; p++) {
            while (n % p == 0) {
                left_prime_count[p]++;
                right_prime_count[p]--;
                n /= p;
            }
        }
        if (n > 1) {
            left_prime_count[n]++;
            right_prime_count[n]--;
        }

        int flag = 1;
        for (int p = 2; p <= max_num; p++) {
            if (left_prime_count[p] > 0 && right_prime_count[p] > 0) {
                flag = 0;
                break;
            }
        }

        if (flag) {
            idx = i;
            break;
        }
    }

    if (idx == -1) {
        result[0] = -1;
        *returnSize = 1;
    } else {
        result[0] = idx;
        *returnSize = 1;
    }

    free(prime_count);
    free(left_prime_count);
    free(right_prime_count);

    return result;
}