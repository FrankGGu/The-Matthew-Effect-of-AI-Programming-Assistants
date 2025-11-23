#include <string.h>

char * smallestPalindrome(char * s){
    int n = strlen(s);
    for (int i = 0; i < n / 2; i++) {
        if (s[i] != s[n - 1 - i]) {
            if (s[i] < s[n - 1 - i]) {
                s[n - 1 - i] = s[i];
            } else {
                s[i] = s[n - 1 - i];
            }
        }
    }
    return s;
}