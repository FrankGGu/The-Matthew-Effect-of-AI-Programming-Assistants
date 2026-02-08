#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getSmallestNumber(char* pattern) {
    int n = strlen(pattern);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int* nums = (int*)malloc((n + 1) * sizeof(int));

    for (int i = 0; i <= n; i++) {
        nums[i] = i + 1;
    }

    for (int i = 0; i < n; i++) {
        if (pattern[i] == 'D') {
            int j = i;
            while (j >= 0 && pattern[j] == 'D') {
                j--;
            }
            int k = i;
            while (k < n && pattern[k] == 'D') {
                k++;
            }
            int len = k - j - 1;
            int* temp = (int*)malloc(len * sizeof(int));
            for (int m = 0; m < len; m++) {
                temp[m] = nums[j + 1 + m];
            }
            for (int m = 0; m < len; m++) {
                nums[j + 1 + m] = temp[len - 1 - m];
            }
            free(temp);
        }
    }

    for (int i = 0; i <= n; i++) {
        result[i] = nums[i] + '0';
    }
    result[n] = '\0';

    free(nums);
    return result;
}