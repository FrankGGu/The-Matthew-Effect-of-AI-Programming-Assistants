#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* largestTimeFromDigits(int* A, int ASize) {
    char* result = (char*)malloc(6 * sizeof(char));
    int maxTime = -1;

    for (int i = 0; i < ASize; i++) {
        for (int j = 0; j < ASize; j++) {
            if (j == i) continue;
            for (int k = 0; k < ASize; k++) {
                if (k == i || k == j) continue;
                int l = 6 - i - j - k;
                int hour = A[i] * 10 + A[j];
                int minute = A[k] * 10 + A[l];
                if (hour < 24 && minute < 60) {
                    int time = hour * 60 + minute;
                    if (time > maxTime) {
                        maxTime = time;
                    }
                }
            }
        }
    }

    if (maxTime == -1) {
        strcpy(result, "");
    } else {
        sprintf(result, "%02d:%02d", maxTime / 60, maxTime % 60);
    }

    return result;
}