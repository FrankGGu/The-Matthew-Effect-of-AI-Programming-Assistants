#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char * largestTimeFromDigits(int* A, int ASize){
    int max_total_minutes = -1;
    char* result = (char*)malloc(sizeof(char) * 6); // HH:MM\0

    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            if (j == i) continue;
            for (int k = 0; k < 4; k++) {
                if (k == i || k == j) continue;
                for (int l = 0; l < 4; l++) {
                    if (l == i || l == j || l == k) continue;

                    int h = A[i] * 10 + A[j];
                    int m = A[k] * 10 + A[l];

                    if (h >= 0 && h <= 23 && m >= 0 && m <= 59) {
                        int current_total_minutes = h * 60 + m;
                        if (current_total_minutes > max_total_minutes) {
                            max_total_minutes = current_total_minutes;
                        }
                    }
                }
            }
        }
    }

    if (max_total_minutes == -1) {
        result[0] = '\0';
    } else {
        int max_h = max_total_minutes / 60;
        int max_m = max_total_minutes % 60;
        sprintf(result, "%02d:%02d", max_h, max_m);
    }

    return result;
}