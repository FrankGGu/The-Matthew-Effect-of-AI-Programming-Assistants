#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDistance(int* colors, int colorsSize) {
    int max_dist = 0;
    for (int i = 0; i < colorsSize; i++) {
        for (int j = colorsSize - 1; j > i; j--) {
            if (colors[i] != colors[j]) {
                int dist = j - i;
                if (dist > max_dist) {
                    max_dist = dist;
                }
                break;
            }
        }
    }
    return max_dist;
}