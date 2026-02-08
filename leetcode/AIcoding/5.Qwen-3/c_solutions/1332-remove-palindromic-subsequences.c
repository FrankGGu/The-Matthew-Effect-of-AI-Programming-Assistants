#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int removePalindromeSub(char *s) {
    int len = strlen(s);
    if (len == 0) return 0;
    int is_palindrome = 1;
    for (int i = 0; i < len / 2; i++) {
        if (s[i] != s[len - 1 - i]) {
            is_palindrome = 0;
            break;
        }
    }
    return is_palindrome ? 1 : 2;
}