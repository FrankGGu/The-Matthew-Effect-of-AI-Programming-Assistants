#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int iceBreakingGame(int n, int m) {
    bool survived[n];
    for (int i = 0; i < n; i++) {
        survived[i] = true;
    }

    int count = n;
    int current = 0;
    int step = 1;

    while (count > 1) {
        if (survived[current]) {
            if (step == m) {
                survived[current] = false;
                count--;
                step = 1;
            } else {
                step++;
            }
        }
        current = (current + 1) % n;
    }

    for (int i = 0; i < n; i++) {
        if (survived[i]) {
            return i + 1;
        }
    }

    return -1;
}