#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findLucky(int* arr, int arrSize) {
    int count[501] = {0};
    for (int i = 0; i < arrSize; i++) {
        count[arr[i]]++;
    }
    int lucky = -1;
    for (int i = 1; i <= 500; i++) {
        if (count[i] == i) {
            lucky = i;
        }
    }
    return lucky;
}