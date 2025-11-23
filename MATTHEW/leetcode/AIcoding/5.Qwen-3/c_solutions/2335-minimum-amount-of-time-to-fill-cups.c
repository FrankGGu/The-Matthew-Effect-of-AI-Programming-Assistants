#include <stdio.h>
#include <stdlib.h>

int fillCups(int* capacity, int n) {
    int time = 0;
    while (1) {
        int max = 0;
        int idx = -1;
        for (int i = 0; i < n; i++) {
            if (capacity[i] > max) {
                max = capacity[i];
                idx = i;
            }
        }
        if (max == 0) break;
        for (int i = 0; i < n; i++) {
            if (i != idx && capacity[i] > 0) {
                capacity[i]--;
            }
        }
        capacity[idx]--;
        time++;
    }
    return time;
}