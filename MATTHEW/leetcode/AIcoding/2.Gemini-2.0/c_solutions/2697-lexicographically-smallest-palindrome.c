#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * makeSmallestPalindrome(char * s){
    int len = strlen(s);
    for (int i = 0; i < len / 2; i++) {
        if (s[i] != s[len - 1 - i]) {
            if (s[i] < s[len - 1 - i]) {
                s[len - 1 - i] = s[i];
            } else {
                s[i] = s[len - 1 - i];
            }
        }
    }
    return s;
}