#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int flipgame(int* fronts, int frontsSize, int* backs, int backsSize) {
    int seen[2001] = {0};
    for (int i = 0; i < frontsSize; i++) {
        if (fronts[i] == backs[i]) {
            seen[fronts[i]] = 1;
        }
    }
    int min = 2001;
    for (int i = 0; i < frontsSize; i++) {
        if (fronts[i] < min && seen[fronts[i]] == 0) {
            min = fronts[i];
        }
        if (backs[i] < min && seen[backs[i]] == 0) {
            min = backs[i];
        }
    }
    if (min == 2001) {
        return 0;
    }
    return min;
}