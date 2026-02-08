#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* addNegabinary(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize){
    int len1 = arr1Size;
    int len2 = arr2Size;
    int len = (len1 > len2) ? len1 : len2;
    int* sum = (int*)malloc(sizeof(int) * (len + 2));
    for (int i = 0; i < len + 2; i++) {
        sum[i] = 0;
    }

    int i = len1 - 1;
    int j = len2 - 1;
    int k = len + 1;

    while (i >= 0 || j >= 0) {
        int a = (i >= 0) ? arr1[i] : 0;
        int b = (j >= 0) ? arr2[j] : 0;
        sum[k] += a + b;
        i--;
        j--;
        if (sum[k] >= 2) {
            sum[k] -= 2;
            sum[k - 1] -= 1;
        } else if (sum[k] == -1) {
            sum[k] = 1;
            sum[k - 1] += 1;
        }
        k--;
    }

    while (k >= 0 && sum[k] == 0) {
        k++;
    }

    if (k > len + 1) {
        k = len + 1;
    }

    int size = len + 2 - k;
    if (size == 0) {
        size = 1;
    }
    *returnSize = size;

    int* result = (int*)malloc(sizeof(int) * size);
    if (size == 1 && k == len + 2 && sum[len+1] == 0){
        result[0] = 0;
        return result;
    }

    for (int l = 0; l < size; l++) {
        result[l] = sum[k + l];
    }

    free(sum);
    return result;
}