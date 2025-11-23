#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findClosest(int a[], int aSize, int b[], int bSize, int x) {
    int closest = INT_MAX;
    int minDiff = INT_MAX;

    for (int i = 0; i < bSize; i++) {
        int diff = abs(b[i] - x);
        if (diff < minDiff) {
            minDiff = diff;
            closest = b[i];
        } else if (diff == minDiff && b[i] < closest) {
            closest = b[i];
        }
    }

    return closest;
}