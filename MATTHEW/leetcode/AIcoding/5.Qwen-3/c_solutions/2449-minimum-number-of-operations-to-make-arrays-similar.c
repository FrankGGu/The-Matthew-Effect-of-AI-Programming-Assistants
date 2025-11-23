#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long long int compare(const void *a, const void *b) {
    return (*(long long int*)a - *(long long int*)b);
}

long long int minOperations(int* nums, int numsSize, int* target, int targetSize, int* numsDiv, int numsDivSize, int* targetDiv, int targetDivSize) {
    qsort(nums, numsSize, sizeof(long long int), compare);
    qsort(target, targetSize, sizeof(long long int), compare);

    long long int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        operations += labs(nums[i] - target[i]);
    }
    return operations / 2;
}

int main() {
    return 0;
}