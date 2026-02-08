#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b, void *map) {
    int *arr = (int *)map;
    int num1 = *(int *)a;
    int num2 = *(int *)b;

    long long mapped_num1 = 0;
    long long mapped_num2 = 0;
    long long multiplier1 = 1;
    long long multiplier2 = 1;

    if (num1 == 0) {
        mapped_num1 = arr[0];
    } else {
        int temp_num1 = num1;
        while (temp_num1 > 0) {
            mapped_num1 += (long long)arr[temp_num1 % 10] * multiplier1;
            multiplier1 *= 10;
            temp_num1 /= 10;
        }
    }

    if (num2 == 0) {
        mapped_num2 = arr[0];
    } else {
        int temp_num2 = num2;
        while (temp_num2 > 0) {
            mapped_num2 += (long long)arr[temp_num2 % 10] * multiplier2;
            multiplier2 *= 10;
            temp_num2 /= 10;
        }
    }

    if (mapped_num1 < mapped_num2) {
        return -1;
    } else if (mapped_num1 > mapped_num2) {
        return 1;
    } else {
        return num1 - num2;
    }
}

int *sortJumbled(int *mapping, int mappingSize, int *nums, int numsSize, int *returnSize) {
    qsort_r(nums, numsSize, sizeof(int), compare, mapping);
    *returnSize = numsSize;
    return nums;
}