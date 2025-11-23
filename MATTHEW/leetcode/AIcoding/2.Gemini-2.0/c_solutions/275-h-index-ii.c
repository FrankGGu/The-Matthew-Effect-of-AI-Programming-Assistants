#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int hIndex(int* citations, int citationsSize){
    int left = 0;
    int right = citationsSize - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int h = citationsSize - mid;

        if (citations[mid] >= h) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return citationsSize - left;
}