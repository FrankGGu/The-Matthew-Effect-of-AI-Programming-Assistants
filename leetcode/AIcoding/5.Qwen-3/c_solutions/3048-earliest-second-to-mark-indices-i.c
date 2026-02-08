#include <stdio.h>
#include <stdlib.h>

int earliestSecond(int* s, int sSize) {
    int n = sSize;
    int* positions = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        positions[i] = -1;
    }

    int time = 0;
    int count = 0;

    while (count < n) {
        for (int i = 0; i < n; i++) {
            if (positions[i] == -1 && s[i] == time) {
                positions[i] = time;
                count++;
            }
        }
        time++;
    }

    free(positions);
    return time - 1;
}