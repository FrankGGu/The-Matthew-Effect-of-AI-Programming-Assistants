#include <stdlib.h> // For malloc, free, qsort

int compareLongLong(const void *a, const void *b) {
    long long valA = *(const long long *)a;
    long long valB = *(const long long *)b;
    if (valA < valB) return 1; // valA comes after valB if valA is smaller
    if (valA > valB) return -1; // valA comes before valB if valA is larger
    return 0;
}

int maximizeScore(int* nums, int numsSize, int k) {
    long long MOD = 1e9 + 7;

    int* left_smaller = (int*)malloc(numsSize * sizeof(int));
    int* right_smaller = (int*)malloc(numsSize * sizeof(int));
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int stack_top = -1; // Represents the top of the stack

    // Find left_smaller: index of the first element to the left that is strictly smaller than nums[i]
    for (int i = 0; i < numsSize; ++i) {
        while (stack_top != -1 && nums[stack[stack_top]] >= nums[i]) {
            stack_top--;
        }
        if (stack_top != -1) {
            left_smaller[i] = stack[stack_top];
        } else {
            left_smaller[i] = -1; // No smaller element to the left
        }
        stack_top++;
        stack[stack_top] = i;
    }

    // Reset stack
    stack_top = -1;

    // Find right_smaller: index of the first element to the right that is strictly smaller than nums[i]
    for (int i = numsSize - 1; i >= 0; --i) {
        while (stack_top != -1 && nums[stack[stack_top]] >= nums[i]) {
            stack_top--;
        }
        if (stack_top != -1) {
            right_smaller[i] = stack[stack_top];
        } else {
            right_smaller[i] = numsSize; // No smaller element to the right
        }
        stack_top++;
        stack[stack_top] = i;
    }

    long long* scores = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; ++i) {
        // The length of the maximal subarray where nums[i] is the minimum
        // is (right_smaller[i] - 1) - (left_smaller[i] + 1) + 1
        // which simplifies to right_smaller[i] - left_smaller[i] - 1
        long long len = (long long)right_smaller[i] - left_smaller[i] - 1;
        scores[i] = (long long)nums[i] * len;
    }

    // Sort the scores in descending order
    qsort(scores, numsSize, sizeof(long long), compareLongLong);

    long long total_score = 0;
    for (int i = 0; i < k; ++i) {
        total_score = (total_score + scores[i]) % MOD;
    }

    free(left_smaller);
    free(right_smaller);
    free(stack);
    free(scores);

    return (int)total_score;
}