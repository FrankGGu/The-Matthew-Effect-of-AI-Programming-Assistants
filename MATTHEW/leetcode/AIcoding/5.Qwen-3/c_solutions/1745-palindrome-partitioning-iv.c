#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPalindrome(char *s, int left, int right) {
    while (left < right) {
        if (s[left] != s[right]) return false;
        left++;
        right--;
    }
    return true;
}

bool* getPartition(char *s, int *resultSize) {
    int n = strlen(s);
    bool *dp = (bool *)calloc(n, sizeof(bool));
    bool *res = (bool *)calloc(n, sizeof(bool));
    dp[0] = true;
    for (int i = 1; i < n; i++) {
        if (isPalindrome(s, 0, i)) {
            dp[i] = true;
        } else {
            for (int j = 0; j < i; j++) {
                if (dp[j] && isPalindrome(s, j + 1, i)) {
                    dp[i] = true;
                    break;
                }
            }
        }
    }
    *resultSize = n;
    return dp;
}

bool* partition(char *s, int *returnSize) {
    int n = strlen(s);
    bool *dp = getPartition(s, returnSize);
    return dp;
}