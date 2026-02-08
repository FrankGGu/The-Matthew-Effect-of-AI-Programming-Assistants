#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getPermutation(int n, int k) {
    int i;
    int* factorial = (int*)malloc(n * sizeof(int));
    char* result = (char*)malloc(n * sizeof(char));
    int* nums = (int*)malloc(n * sizeof(int));

    factorial[0] = 1;
    for (i = 1; i < n; i++) {
        factorial[i] = factorial[i - 1] * i;
    }

    for (i = 0; i < n; i++) {
        nums[i] = i + 1;
    }

    k--;
    for (i = 0; i < n; i++) {
        int index = k / factorial[n - 1 - i];
        result[i] = '0' + nums[index];
        for (int j = index; j < n - 1 - i; j++) {
            nums[j] = nums[j + 1];
        }
        k = k % factorial[n - 1 - i];
    }

    result[n] = '\0';
    free(factorial);
    free(nums);
    return result;
}