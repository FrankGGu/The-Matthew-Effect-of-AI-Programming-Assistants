#include <stdlib.h>
#include <string.h>

int isPalindromic(int num) {
    char str[20];
    sprintf(str, "%d", num);
    int left = 0, right = strlen(str) - 1;
    while (left < right) {
        if (str[left] != str[right]) return 0;
        left++;
        right--;
    }
    return 1;
}

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

long long minCost(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int median = nums[numsSize / 2];

    int left = median, right = median;
    while (!isPalindromic(left)) left--;
    while (!isPalindromic(right)) right++;

    long long cost1 = 0, cost2 = 0;
    for (int i = 0; i < numsSize; i++) {
        cost1 += abs(nums[i] - left);
        cost2 += abs(nums[i] - right);
    }

    return cost1 < cost2 ? cost1 : cost2;
}