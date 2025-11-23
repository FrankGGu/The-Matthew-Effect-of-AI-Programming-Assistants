#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxWidthRamp(int* A, int ASize) {
    int maxWidth = 0;
    int min_idx[ASize];
    int min_val[ASize];

    min_idx[0] = 0;
    min_val[0] = A[0];

    for (int i = 1; i < ASize; i++) {
        if (A[i] < min_val[i - 1]) {
            min_val[i] = A[i];
            min_idx[i] = i;
        } else {
            min_val[i] = min_val[i - 1];
            min_idx[i] = min_idx[i - 1];
        }
    }

    for (int j = ASize - 1; j > 0; j--) {
        int left = 0;
        int right = j;
        int best_i = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (min_val[mid] <= A[j]) {
                best_i = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (best_i != -1) {
            int width = j - min_idx[best_i];
            if (width > maxWidth) {
                maxWidth = width;
            }
        }
    }

    return maxWidth;
}