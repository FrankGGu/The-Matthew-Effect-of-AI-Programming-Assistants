#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * shiftingLetters(char * s, int** shifts, int shiftsSize, int* shiftsColSize){
    int n = strlen(s);
    int* diff = (int*)malloc(sizeof(int) * (n + 1));
    memset(diff, 0, sizeof(int) * (n + 1));

    for (int i = 0; i < shiftsSize; i++) {
        int start = shifts[i][0];
        int end = shifts[i][1];
        int direction = shifts[i][2];

        if (direction == 1) {
            diff[start] += 1;
            diff[end + 1] -= 1;
        } else {
            diff[start] -= 1;
            diff[end + 1] += 1;
        }
    }

    int currentShift = 0;
    for (int i = 0; i < n; i++) {
        currentShift += diff[i];
        int shift = (currentShift % 26 + 26) % 26; 
        s[i] = 'a' + (s[i] - 'a' + shift) % 26;
    }

    free(diff);
    return s;
}