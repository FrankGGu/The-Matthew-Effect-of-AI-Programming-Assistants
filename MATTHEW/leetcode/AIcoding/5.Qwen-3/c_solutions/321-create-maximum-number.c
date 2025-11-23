#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

void get_max_number(int* nums, int nums_size, int k, int* result) {
    int* stack = (int*)malloc(sizeof(int) * k);
    int top = 0;
    int len = nums_size - k;
    for (int i = 0; i < nums_size; i++) {
        while (top > 0 && stack[top - 1] < nums[i] && len > 0) {
            top--;
            len--;
        }
        if (top < k) {
            stack[top++] = nums[i];
        }
    }
    memcpy(result, stack, sizeof(int) * k);
    free(stack);
}

int compare_subarray(const void *a, const void *b) {
    int* a1 = (int*)a;
    int* b1 = (int*)b;
    int n = strlen((char*)a1);
    for (int i = 0; i < n; i++) {
        if (a1[i] != b1[i]) {
            return b1[i] - a1[i];
        }
    }
    return 0;
}

int* maxNumber(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * k);
    int* temp = (int*)malloc(sizeof(int) * k);
    *returnSize = k;
    for (int i = 0; i <= k; i++) {
        if (i <= nums1Size && k - i <= nums2Size) {
            get_max_number(nums1, nums1Size, i, temp);
            get_max_number(nums2, nums2Size, k - i, temp + i);
            if (memcmp(result, temp, sizeof(int) * k) < 0) {
                memcpy(result, temp, sizeof(int) * k);
            }
        }
    }
    free(temp);
    return result;
}