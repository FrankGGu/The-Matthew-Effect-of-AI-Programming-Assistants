#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

void generateSums(int* nums, int start, int end, int* sums, int* size) {
    int n = end - start + 1;
    int total = 1 << n;
    sums[0] = 0;
    *size = 1;

    for (int i = 0; i < n; i++) {
        int currentSize = *size;
        for (int j = 0; j < currentSize; j++) {
            sums[*size] = sums[j] + nums[start + i];
            (*size)++;
        }
    }
}

int minAbsDifference(int* nums, int numsSize, int goal) {
    if (numsSize == 0) return abs(goal);

    int n = numsSize;
    int half = n / 2;

    int leftSize = 1 << half;
    int rightSize = 1 << (n - half);

    int* leftSums = (int*)malloc(leftSize * sizeof(int));
    int* rightSums = (int*)malloc(rightSize * sizeof(int));

    int leftCount = 0, rightCount = 0;
    generateSums(nums, 0, half - 1, leftSums, &leftCount);
    generateSums(nums, half, n - 1, rightSums, &rightCount);

    qsort(leftSums, leftCount, sizeof(int), cmp);
    qsort(rightSums, rightCount, sizeof(int), cmp);

    int minDiff = abs(goal);
    int left = 0, right = rightCount - 1;

    while (left < leftCount && right >= 0) {
        int sum = leftSums[left] + rightSums[right];
        int diff = abs(sum - goal);
        if (diff < minDiff) minDiff = diff;

        if (sum < goal) {
            left++;
        } else if (sum > goal) {
            right--;
        } else {
            break;
        }
    }

    free(leftSums);
    free(rightSums);

    return minDiff;
}