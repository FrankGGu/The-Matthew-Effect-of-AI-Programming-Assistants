#include <stdio.h>
#include <stdlib.h>

int longestMountain(int* arr, int arrSize) {
    int maxLen = 0;
    int i = 1;
    while (i < arrSize - 1) {
        int up = 0, down = 0;
        if (arr[i] > arr[i - 1]) {
            while (i < arrSize - 1 && arr[i] > arr[i + 1]) {
                i++;
                up++;
            }
            while (i < arrSize - 1 && arr[i] > arr[i + 1]) {
                i++;
                down++;
            }
            if (up > 0 && down > 0) {
                maxLen = (up + down + 1) > maxLen ? (up + down + 1) : maxLen;
            }
        } else {
            i++;
        }
    }
    return maxLen;
}