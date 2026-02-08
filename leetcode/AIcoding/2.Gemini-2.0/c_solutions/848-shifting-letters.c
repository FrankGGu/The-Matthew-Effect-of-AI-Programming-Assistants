#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * shiftingLetters(char * s, int* shifts, int shiftsSize){
    long long shift = 0;
    int len = strlen(s);
    for (int i = 0; i < shiftsSize; i++) {
        shift = (shift + shifts[i]) % 26;
    }

    for (int i = 0; i < len; i++) {
        long long currentShift = shift;
        s[i] = (s[i] - 'a' + currentShift) % 26 + 'a';
        shift = (shift - shifts[i]) % 26;
        if (shift < 0) {
            shift += 26;
        }
    }
    return s;
}