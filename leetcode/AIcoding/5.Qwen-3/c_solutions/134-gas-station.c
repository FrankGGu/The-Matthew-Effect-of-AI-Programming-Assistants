#include <stdio.h>
#include <stdlib.h>

int canCompleteCircuit(int* gas, int gasSize, int* cost, int costSize) {
    int total = 0;
    int current = 0;
    int start = 0;

    for (int i = 0; i < gasSize; i++) {
        total += gas[i] - cost[i];
        current += gas[i] - cost[i];
        if (current < 0) {
            start = i + 1;
            current = 0;
        }
    }

    return (total >= 0) ? start : -1;
}