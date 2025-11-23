#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int garbageCollection(char** garbage, int garbageSize, int* travel, int travelSize) {
    int time = 0;
    int* prefix = (int*)malloc(travelSize * sizeof(int));
    for (int i = 0; i < travelSize; i++) {
        prefix[i] = (i == 0) ? 0 : prefix[i - 1] + travel[i - 1];
    }

    int m = 0, p = 0, g = 0;
    for (int i = 0; i < garbageSize; i++) {
        char* s = garbage[i];
        for (int j = 0; j < strlen(s); j++) {
            if (s[j] == 'M') m++;
            else if (s[j] == 'P') p++;
            else if (s[j] == 'G') g++;
        }
    }

    for (int i = 0; i < garbageSize; i++) {
        char* s = garbage[i];
        for (int j = 0; j < strlen(s); j++) {
            if (s[j] == 'M') m--;
            else if (s[j] == 'P') p--;
            else if (s[j] == 'G') g--;
        }
        if (m > 0) time += prefix[i];
        if (p > 0) time += prefix[i];
        if (g > 0) time += prefix[i];
    }

    time += (m + p + g);
    free(prefix);
    return time;
}