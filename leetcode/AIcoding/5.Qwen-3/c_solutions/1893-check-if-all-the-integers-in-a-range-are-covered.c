#include <stdio.h>
#include <stdlib.h>

bool areNumbersCovered(int** ranges, int rangesSize, int* rangesColSize, int left, int right) {
    bool* covered = (bool*)calloc(right - left + 1, sizeof(bool));
    for (int i = 0; i < rangesSize; i++) {
        int start = ranges[i][0];
        int end = ranges[i][1];
        for (int j = start; j <= end && j <= right; j++) {
            if (j >= left) {
                covered[j - left] = true;
            }
        }
    }
    for (int i = 0; i < right - left + 1; i++) {
        if (!covered[i]) {
            free(covered);
            return false;
        }
    }
    free(covered);
    return true;
}