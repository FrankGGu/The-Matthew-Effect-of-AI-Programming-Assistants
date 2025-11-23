#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isPalindrome(char *s) {
    int len = strlen(s);
    for (int i = 0; i < len / 2; i++) {
        if (s[i] != s[len - 1 - i]) return 0;
    }
    return 1;
}

void generateSubsequences(char *s, int index, char *current, int *maxProduct, int *maxLen) {
    if (index == strlen(s)) {
        if (isPalindrome(current)) {
            int len = strlen(current);
            if (len > 0 && *maxLen[0] > 0) {
                *maxProduct = (*maxProduct) < (len * *maxLen[0]) ? (len * *maxLen[0]) : *maxProduct;
            }
            if (len > *maxLen[0]) {
                *maxLen[0] = len;
            }
        }
        return;
    }

    generateSubsequences(s, index + 1, current, maxProduct, maxLen);

    char *newCurrent = (char *)malloc(strlen(current) + 2);
    strcpy(newCurrent, current);
    newCurrent[strlen(current)] = s[index];
    newCurrent[strlen(current) + 1] = '\0';
    generateSubsequences(s, index + 1, newCurrent, maxProduct, maxLen);
    free(newCurrent);
}

int maxProductOfTwoPalindromicSubsequences(char *s) {
    int maxProduct = 0;
    int maxLen[1] = {0};
    char *current = (char *)malloc(1);
    current[0] = '\0';
    generateSubsequences(s, 0, current, &maxProduct, maxLen);
    free(current);
    return maxProduct;
}