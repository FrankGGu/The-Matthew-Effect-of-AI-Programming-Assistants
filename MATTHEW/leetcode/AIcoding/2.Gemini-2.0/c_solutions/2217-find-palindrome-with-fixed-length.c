#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long* kthPalindrome(int queries[], int queriesSize, int intLength, int* returnSize) {
    *returnSize = queriesSize;
    long long* result = (long long*)malloc(queriesSize * sizeof(long long));

    int halfLength = (intLength + 1) / 2;
    long long start = (long long)pow(10, halfLength - 1);
    long long end = (long long)pow(10, halfLength) - 1;
    long long count = end - start + 1;

    for (int i = 0; i < queriesSize; i++) {
        if (queries[i] > count) {
            result[i] = -1;
        } else {
            long long num = start + queries[i] - 1;
            long long temp = num;
            long long palindrome = num;
            if (intLength % 2 == 0) {
                temp /= 10;
            }
            while (temp > 0) {
                palindrome = palindrome * 10 + (temp % 10);
                temp /= 10;
            }
            result[i] = palindrome;
        }
    }

    return result;
}