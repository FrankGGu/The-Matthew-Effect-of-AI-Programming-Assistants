#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPalindrome(char* s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) {
            return false;
        }
        start++;
        end--;
    }
    return true;
}

bool checkPartitioning(char* s) {
    int n = strlen(s);
    for (int i = 1; i < n - 1; i++) {
        if (isPalindrome(s, 0, i - 1)) {
            for (int j = i + 1; j < n; j++) {
                if (isPalindrome(s, i, j - 1) && isPalindrome(s, j, n - 1)) {
                    return true;
                }
            }
        }
    }
    return false;
}