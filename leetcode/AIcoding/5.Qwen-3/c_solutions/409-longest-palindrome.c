#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestPalindrome(char *s) {
    int count[128] = {0};
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        count[(int)s[i]]++;
    }
    int odd = 0;
    for (int i = 0; i < 128; i++) {
        if (count[i] % 2 != 0) {
            odd = 1;
        }
    }
    return len - odd + 1;
}