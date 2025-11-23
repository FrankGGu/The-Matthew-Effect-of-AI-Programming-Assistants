#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int makeArrayIncreasing(int* arr1, int arr1Size, int* arr2, int arr2Size){
    qsort(arr2, arr2Size, sizeof(int), (int (*)(const void *, const void *))cmpfunc);

    int* uniqueArr2 = (int*)malloc(arr2Size * sizeof(int));
    int uniqueSize = 0;
    if (arr2Size > 0) {
        uniqueArr2[uniqueSize++] = arr2[0];
        for (int i = 1; i < arr2Size; i++) {
            if (arr2[i] != arr2[i - 1]) {
                uniqueArr2[uniqueSize++] = arr2[i];
            }
        }
    }

    int** dp = (int**)malloc((arr1Size + 1) * sizeof(int*));
    for (int i = 0; i <= arr1Size; i++) {
        dp[i] = (int*)malloc((arr1Size + 1) * sizeof(int));
        for (int j = 0; j <= arr1Size; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    dp[0][0] = -1;

    for (int i = 1; i <= arr1Size; i++) {
        for (int j = 0; j <= i; j++) {
            if (arr1[i - 1] > dp[i - 1][j]) {
                dp[i][j] = arr1[i - 1];
            }

            if (j > 0 && dp[i - 1][j - 1] != INT_MAX) {
                int* ptr = upper_bound(uniqueArr2, uniqueArr2 + uniqueSize, dp[i - 1][j - 1]);
                if (ptr != uniqueArr2 + uniqueSize) {
                    int val = *ptr;
                    dp[i][j] = min(dp[i][j], val);
                }
            }
        }
    }

    int result = -1;
    for (int j = 0; j <= arr1Size; j++) {
        if (dp[arr1Size][j] != INT_MAX) {
            result = j;
            break;
        }
    }

    for (int i = 0; i <= arr1Size; i++) {
        free(dp[i]);
    }
    free(dp);
    free(uniqueArr2);

    return result;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int* upper_bound(int *begin, int *end, int target) {
    int *left = begin, *right = end;
    while (left < right) {
        int *mid = left + (right - left) / 2;
        if (*mid <= target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}