#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * modifyString(char * s){
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (s[i] == '?') {
            for (char c = 'a'; c <= 'c'; c++) {
                if ((i > 0 && s[i - 1] == c) || (i < len - 1 && s[i + 1] == c)) {
                    continue;
                }
                s[i] = c;
                break;
            }
        }
    }
    return s;
}