#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* shiftingLetters(int n, char* s, int* shifts, int shiftsSize) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int totalShift = 0;
    for (int i = n - 1; i >= 0; i--) {
        totalShift = (totalShift + shifts[i]) % 26;
        result[i] = 'a' + (s[i] - 'a' + totalShift) % 26;
    }
    result[n] = '\0';
    return result;
}