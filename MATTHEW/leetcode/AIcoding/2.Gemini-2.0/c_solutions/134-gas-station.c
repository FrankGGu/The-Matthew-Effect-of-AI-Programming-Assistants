#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int canCompleteCircuit(int* gas, int gasSize, int* cost, int costSize) {
    int total_gas = 0;
    int current_gas = 0;
    int start = 0;

    for (int i = 0; i < gasSize; i++) {
        total_gas += gas[i] - cost[i];
        current_gas += gas[i] - cost[i];
        if (current_gas < 0) {
            start = i + 1;
            current_gas = 0;
        }
    }

    return (total_gas >= 0) ? start : -1;
}