#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * getPermutation(int n, int k){
    int i, j, fact[n + 1];
    char *result = (char *)malloc((n + 1) * sizeof(char));
    int *nums = (int *)malloc(n * sizeof(int));

    fact[0] = 1;
    for (i = 1; i <= n; i++) {
        fact[i] = fact[i - 1] * i;
        nums[i - 1] = i;
    }
    k--;

    for (i = 0; i < n; i++) {
        int index = k / fact[n - 1 - i];
        result[i] = nums[index] + '0';

        for (j = index; j < n - 1 - i; j++) {
            nums[j] = nums[j + 1];
        }

        k %= fact[n - 1 - i];
    }

    result[n] = '\0';
    free(nums);

    return result;
}