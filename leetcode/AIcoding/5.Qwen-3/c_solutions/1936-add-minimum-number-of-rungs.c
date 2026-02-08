#include <stdio.h>
#include <stdlib.h>

int addRungs(int* rungs, int rungsSize, int dist) {
    int count = 0;
    int prev = 0;
    for (int i = 0; i < rungsSize; i++) {
        int diff = rungs[i] - prev;
        if (diff > dist) {
            count += (diff - 1) / dist;
        }
        prev = rungs[i];
    }
    return count;
}