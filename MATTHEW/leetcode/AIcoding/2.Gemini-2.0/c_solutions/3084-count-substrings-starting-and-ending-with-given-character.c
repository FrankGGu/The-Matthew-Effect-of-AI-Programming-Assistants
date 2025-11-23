#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubstrings(char * s, char ch){
    int count = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        if (s[i] == ch) {
            for (int j = i; j < len; j++) {
                if (s[j] == ch) {
                    count++;
                }
            }
        }
    }

    return count;
}