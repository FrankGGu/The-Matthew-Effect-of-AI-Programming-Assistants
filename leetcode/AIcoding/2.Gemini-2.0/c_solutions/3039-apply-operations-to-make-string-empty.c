#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * makeTheStringGreat(char * s){
    int len = strlen(s);
    if (len <= 1) return s;

    int i = 0;
    while (i < len - 1) {
        if (s[i] != s[i+1] && (s[i] == s[i+1] - 32 || s[i] == s[i+1] + 32)) {
            for (int j = i; j < len - 2; j++) {
                s[j] = s[j+2];
            }
            len -= 2;
            s[len] = '\0';
            if (i > 0) {
                i--;
            }
        } else {
            i++;
        }
    }

    return s;
}