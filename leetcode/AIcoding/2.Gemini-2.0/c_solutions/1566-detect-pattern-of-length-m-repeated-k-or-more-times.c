#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool containsPattern(int* arr, int arrSize, int m, int k) {
    for (int i = 0; i <= arrSize - m * k; i++) {
        bool match = true;
        for (int j = 1; j < k; j++) {
            for (int l = 0; l < m; l++) {
                if (arr[i + l] != arr[i + j * m + l]) {
                    match = false;
                    break;
                }
            }
            if (!match) break;
        }
        if (match) return true;
    }
    return false;
}