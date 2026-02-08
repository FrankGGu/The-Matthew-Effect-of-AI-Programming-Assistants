#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSegments(char * s){
    int count = 0;
    int len = strlen(s);
    int in_word = 0;

    for (int i = 0; i < len; i++) {
        if (s[i] != ' ') {
            if (!in_word) {
                count++;
                in_word = 1;
            }
        } else {
            in_word = 0;
        }
    }

    return count;
}