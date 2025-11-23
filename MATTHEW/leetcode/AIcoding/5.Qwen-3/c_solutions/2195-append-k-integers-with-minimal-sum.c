#include <stdio.h>
#include <stdlib.h>

long long minimalKSum(int* nums, int numsSize, int k) {
    long long sum = 0;
    int* unique = (int*)malloc(numsSize * sizeof(int));
    int uniqueSize = 0;
    for (int i = 0; i < numsSize; i++) {
        int found = 0;
        for (int j = 0; j < uniqueSize; j++) {
            if (nums[i] == unique[j]) {
                found = 1;
                break;
            }
        }
        if (!found) {
            unique[uniqueSize++] = nums[i];
        }
    }
    qsort(unique, uniqueSize, sizeof(int), (int (*)(const void*, const void*))strcmp);
    int i = 0;
    long long current = 1;
    while (k > 0 && i < uniqueSize) {
        if (current < unique[i]) {
            long long count = unique[i] - current;
            if (count > k) {
                sum += (current + (current + k - 1)) * k / 2;
                k = 0;
            } else {
                sum += (current + (unique[i] - 1)) * count / 2;
                k -= count;
                current = unique[i] + 1;
            }
        } else {
            current = unique[i] + 1;
            i++;
        }
    }
    if (k > 0) {
        sum += (current + (current + k - 1)) * k / 2;
    }
    free(unique);
    return sum;
}