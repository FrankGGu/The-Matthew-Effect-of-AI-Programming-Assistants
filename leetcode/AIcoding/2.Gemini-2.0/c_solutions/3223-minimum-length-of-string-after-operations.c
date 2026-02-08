#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minLength(char * s){
    int n = strlen(s);
    int i = 0, j = n - 1;
    while (i < j) {
        if (s[i] == s[j]) {
            char c = s[i];
            while (i < n && s[i] == c) {
                i++;
            }
            while (j >= 0 && s[j] == c) {
                j--;
            }
        } else {
            break;
        }
    }
    return j - i + 1 > 0 ? j - i + 1 : 0;
}