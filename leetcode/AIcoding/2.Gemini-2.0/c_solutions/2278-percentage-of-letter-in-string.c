#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int percentageLetter(char * s, char c){
    int count = 0;
    int len = 0;
    while (s[len] != '\0') {
        len++;
    }

    for (int i = 0; i < len; i++) {
        if (s[i] == c) {
            count++;
        }
    }

    return (int)(((double)count / len) * 100);
}