#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int removePalindromeSub(char * s){
    int len = strlen(s);
    if (len == 0) return 0;

    bool isPalindrome = true;
    for (int i = 0; i < len / 2; i++) {
        if (s[i] != s[len - 1 - i]) {
            isPalindrome = false;
            break;
        }
    }

    if (isPalindrome) return 1;
    else return 2;
}