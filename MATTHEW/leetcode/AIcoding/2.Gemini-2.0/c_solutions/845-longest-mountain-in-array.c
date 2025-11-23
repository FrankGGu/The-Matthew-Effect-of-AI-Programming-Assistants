#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestMountain(int* arr, int arrSize) {
    int maxLen = 0;
    for (int i = 1; i < arrSize - 1; i++) {
        if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
            int left = i - 1;
            while (left > 0 && arr[left] > arr[left - 1]) {
                left--;
            }
            int right = i + 1;
            while (right < arrSize - 1 && arr[right] > arr[right - 1]) {
                right++;
            }
            int len = right - left + 1;
            if (len > maxLen) {
                maxLen = len;
            }
        }
    }
    return maxLen;
}