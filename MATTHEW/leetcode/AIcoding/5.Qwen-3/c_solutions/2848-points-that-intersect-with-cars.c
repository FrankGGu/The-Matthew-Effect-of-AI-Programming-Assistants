#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int numberOfPoints(int** times, int timesSize, int* timesColSize) {
    int points[201] = {0};
    for (int i = 0; i < timesSize; i++) {
        int start = times[i][0];
        int end = times[i][1];
        for (int j = start; j <= end; j++) {
            points[j]++;
        }
    }
    int count = 0;
    for (int i = 0; i <= 200; i++) {
        if (points[i] > 0) {
            count++;
        }
    }
    return count;
}