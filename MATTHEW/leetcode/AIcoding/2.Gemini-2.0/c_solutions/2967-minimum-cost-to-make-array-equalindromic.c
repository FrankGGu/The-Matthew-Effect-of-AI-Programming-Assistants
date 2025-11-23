#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long cost(int* nums, int numsSize, int target) {
    long long res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(nums[i] - target);
    }
    return res;
}

bool isPalindrome(int n) {
    if (n < 0) return false;
    int temp = n;
    int rev = 0;
    while (temp > 0) {
        rev = rev * 10 + temp % 10;
        temp /= 10;
    }
    return n == rev;
}

int nextPalindrome(int n) {
    n++;
    while (!isPalindrome(n)) {
        n++;
    }
    return n;
}

int prevPalindrome(int n) {
    if (n <= 0) return 0;
    n--;
    while (!isPalindrome(n)) {
        n--;
    }
    return n;
}

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

long long makeArrayEqualindromic(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int median = nums[numsSize / 2];
    int prev = prevPalindrome(median);
    int next = nextPalindrome(median);

    long long cost1 = cost(nums, numsSize, median);
    long long cost2 = cost(nums, numsSize, prev);
    long long cost3 = cost(nums, numsSize, next);

    long long minCost = cost1;
    if (cost2 < minCost) minCost = cost2;
    if (cost3 < minCost) minCost = cost3;

    return minCost;
}