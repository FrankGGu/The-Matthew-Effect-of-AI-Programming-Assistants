#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkPalindrome(char *s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) {
            return false;
        }
        start++;
        end--;
    }
    return true;
}

bool check(char *a, char *b) {
    int n = strlen(a);
    int i = 0, j = n - 1;
    while (i < j && a[i] == b[j]) {
        i++;
        j--;
    }
    return checkPalindrome(a, i, j) || checkPalindrome(b, i, j);
}

bool checkPalindromeFormation(char *a, char *b) {
    return check(a, b) || check(b, a);
}