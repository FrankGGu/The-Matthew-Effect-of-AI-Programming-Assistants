#include <stdio.h>
#include <stdlib.h>

bool canReach(int* arr, int arrSize, int start) {
    if (start < 0 || start >= arrSize || arr[start] == -1) {
        return false;
    }
    if (arr[start] == 0) {
        return true;
    }
    int val = arr[start];
    arr[start] = -1;
    return canReach(arr, arrSize, start + val) || canReach(arr, arrSize, start - val);
}