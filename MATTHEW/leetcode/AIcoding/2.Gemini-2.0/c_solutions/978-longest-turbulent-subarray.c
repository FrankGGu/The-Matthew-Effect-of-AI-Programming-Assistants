#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxTurbulenceSize(int* arr, int arrSize){
    if (arrSize <= 1) return arrSize;

    int maxLen = 1;
    int start = 0;
    int end = 0;

    while (end < arrSize - 1) {
        if (arr[end] == arr[end + 1]) {
            start = end + 1;
            end = end + 1;
        } else {
            int direction = (arr[end] < arr[end + 1]) ? 1 : -1; 
            end++;
            while (end < arrSize - 1) {
                if ((arr[end] < arr[end + 1] && direction == -1) || (arr[end] > arr[end + 1] && direction == 1)) {
                    direction *= -1;
                    end++;
                } else {
                    break;
                }
            }
            maxLen = (maxLen > end - start + 1) ? maxLen : end - start + 1;
            start = end;
        }
    }

    return maxLen;
}