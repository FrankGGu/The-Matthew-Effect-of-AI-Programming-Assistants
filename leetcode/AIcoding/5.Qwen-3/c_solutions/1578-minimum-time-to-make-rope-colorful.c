#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(char *colors, int *cost, int n) {
    int total = 0;
    for (int i = 1; i < n; i++) {
        if (colors[i] == colors[i - 1]) {
            total += cost[i];
            cost[i] = 0;
        }
    }
    return total;
}