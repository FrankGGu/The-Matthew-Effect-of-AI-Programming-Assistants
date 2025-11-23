#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int specialCharacters(char * s){
    int count = 0;
    int freq[256] = {0};
    for (int i = 0; s[i] != '\0'; i++) {
        freq[(unsigned char)s[i]]++;
    }
    for (int i = 0; i < 256; i++) {
        if (freq[i] > 1) {
            count++;
        }
    }
    return count;
}