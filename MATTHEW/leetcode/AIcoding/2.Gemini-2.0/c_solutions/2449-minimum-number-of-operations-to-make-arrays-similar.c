#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long makeSimilar(int* nums, int numsSize, int* target, int targetSize) {
    int odd_nums[numsSize];
    int even_nums[numsSize];
    int odd_target[targetSize];
    int even_target[targetSize];
    int odd_nums_count = 0;
    int even_nums_count = 0;
    int odd_target_count = 0;
    int even_target_count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            even_nums[even_nums_count++] = nums[i];
        } else {
            odd_nums[odd_nums_count++] = nums[i];
        }
    }

    for (int i = 0; i < targetSize; i++) {
        if (target[i] % 2 == 0) {
            even_target[even_target_count++] = target[i];
        } else {
            odd_target[odd_target_count++] = target[i];
        }
    }

    qsort(odd_nums, odd_nums_count, sizeof(int), cmpfunc);
    qsort(even_nums, even_nums_count, sizeof(int), cmpfunc);
    qsort(odd_target, odd_target_count, sizeof(int), cmpfunc);
    qsort(even_target, even_target_count, sizeof(int), cmpfunc);

    long long operations = 0;
    for (int i = 0; i < odd_nums_count; i++) {
        if (odd_nums[i] > odd_target[i]) {
            operations += (odd_nums[i] - odd_target[i]) / 2;
        }
    }
    for (int i = 0; i < even_nums_count; i++) {
        if (even_nums[i] > even_target[i]) {
            operations += (even_nums[i] - even_target[i]) / 2;
        }
    }

    return operations;
}