#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPalindrome(char *s, int i, int j) {
    while (i < j) {
        if (s[i] != s[j]) {
            return false;
        }
        i++;
        j--;
    }
    return true;
}

bool validPalindrome(char *s) {
    int i = 0;
    int j = strlen(s) - 1;

    while (i < j) {
        if (s[i] != s[j]) {
            return isPalindrome(s, i + 1, j) || isPalindrome(s, i, j - 1);
        }
        i++;
        j--;
    }

    return true;
}