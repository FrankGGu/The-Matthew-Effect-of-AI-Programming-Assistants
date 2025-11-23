#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct Node {
    double value;
    struct Node* next;
};

int cmp(const void* a, const void* b) {
    return (*(double*)b - *(double*)a);
}

double sumArray(double* arr, int size) {
    double sum = 0;
    for (int i = 0; i < size; i++) {
        sum += arr[i];
    }
    return sum;
}

int minOperations(double* nums, int numsSize) {
    double target = sumArray(nums, numsSize) / 2.0;
    int operations = 0;
    double currentSum = 0;

    qsort(nums, numsSize, sizeof(double), cmp);

    for (int i = 0; currentSum < target && i < numsSize; i++) {
        currentSum += nums[i] / 2.0;
        operations++;
    }
    return operations;
}