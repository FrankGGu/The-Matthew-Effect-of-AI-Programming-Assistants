#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

void swap(int *a, int *b) {
    int t = *a;
    *a = *b;
    *b = t;
}

int isSquareful(int *arr, int size) {
    if (size == 1) return 1;
    for (int i = 0; i < size - 1; i++) {
        int diff = arr[i] + arr[i + 1];
        int root = (int)sqrt(diff);
        if (root * root != diff) return 0;
    }
    return 1;
}

int count = 0;

void backtrack(int *nums, int start, int size, int *used, int *current) {
    if (start == size) {
        count++;
        return;
    }
    for (int i = 0; i < size; i++) {
        if (used[i]) continue;
        if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) continue;
        if (start > 0) {
            int prev = current[start - 1];
            int sum = prev + nums[i];
            int root = (int)sqrt(sum);
            if (root * root != sum) continue;
        }
        used[i] = 1;
        current[start] = nums[i];
        backtrack(nums, start + 1, size, used, current);
        used[i] = 0;
    }
}

int numSquarefulArrays(int *nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int *used = (int *)malloc(numsSize * sizeof(int));
    int *current = (int *)malloc(numsSize * sizeof(int));
    count = 0;
    backtrack(nums, 0, numsSize, used, current);
    free(used);
    free(current);
    return count;
}