#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximizeActiveSection(int* start, int startSize, int* end, int endSize) {
    int maxActive = 0;
    for (int i = 0; i < startSize; i++) {
        int active = 0;
        for (int j = 0; j < startSize; j++) {
            if (start[j] <= start[i] && end[j] >= start[i]) {
                active++;
            }
        }
        if (active > maxActive) {
            maxActive = active;
        }
    }
    return maxActive;
}