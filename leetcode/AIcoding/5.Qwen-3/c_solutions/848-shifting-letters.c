#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* shiftingLetters(char* s, int* shifts, int shiftsSize) {
    int n = strlen(s);
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int totalShift = 0;

    for (int i = n - 1; i >= 0; i--) {
        totalShift += shifts[i];
        totalShift %= 26;
        char original = s[i];
        char shifted = ((original - 'a') + totalShift) % 26 + 'a';
        result[i] = shifted;
    }
    result[n] = '\0';
    return result;
}