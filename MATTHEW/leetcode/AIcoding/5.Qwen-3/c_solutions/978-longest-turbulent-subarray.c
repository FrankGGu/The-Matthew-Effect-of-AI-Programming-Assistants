#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int longestTurbulentVariance(int* arr, int arrSize) {
    if (arrSize < 2) return 0;

    int maxLen = 0;
    int n = arrSize;

    for (int i = 0; i < n; i++) {
        int up = 0, down = 0;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] > arr[j - 1]) {
                up = down + 1;
                down = 0;
            } else if (arr[j] < arr[j - 1]) {
                down = up + 1;
                up = 0;
            } else {
                up = 0;
                down = 0;
            }
            maxLen = max(maxLen, up, down);
        }
    }

    return maxLen;
}