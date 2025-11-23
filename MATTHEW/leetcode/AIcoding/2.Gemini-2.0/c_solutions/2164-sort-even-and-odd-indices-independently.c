#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare_odd(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int compare_even(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* sortEvenOdd(int* nums, int numsSize, int* returnSize){
    int even_count = 0;
    int odd_count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            even_count++;
        } else {
            odd_count++;
        }
    }

    int* even_nums = (int*)malloc(even_count * sizeof(int));
    int* odd_nums = (int*)malloc(odd_count * sizeof(int));

    int even_index = 0;
    int odd_index = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            even_nums[even_index++] = nums[i];
        } else {
            odd_nums[odd_index++] = nums[i];
        }
    }

    qsort(even_nums, even_count, sizeof(int), compare_even);
    qsort(odd_nums, odd_count, sizeof(int), compare_odd);

    even_index = 0;
    odd_index = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            nums[i] = even_nums[even_index++];
        } else {
            nums[i] = odd_nums[odd_index++];
        }
    }

    free(even_nums);
    free(odd_nums);

    *returnSize = numsSize;
    return nums;
}