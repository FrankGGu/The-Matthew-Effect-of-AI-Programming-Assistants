#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int addRungs(int* rungs, int rungsSize, int dist) {
    int count = 0;
    int prev = 0;
    for (int i = 0; i < rungsSize; i++) {
        if (rungs[i] - prev > dist) {
            count += (rungs[i] - prev - 1) / dist;
        }
        prev = rungs[i];
    }
    return count;
}