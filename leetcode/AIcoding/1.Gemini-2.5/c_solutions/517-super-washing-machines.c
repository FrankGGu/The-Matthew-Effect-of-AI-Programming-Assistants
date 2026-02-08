#include <stdlib.h> // For abs

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int superWashingMachines(int* machines, int machinesSize) {
    long long totalDresses = 0;
    for (int i = 0; i < machinesSize; i++) {
        totalDresses += machines[i];
    }

    if (totalDresses % machinesSize != 0) {
        return -1;
    }

    int target = (int)(totalDresses / machinesSize);
    int maxMoves = 0;
    int balance = 0; // Represents the net flow of dresses needed/excess from left to right

    for (int i = 0; i < machinesSize; i++) {
        int diff = machines[i] - target;
        balance += diff;

        // The maximum number of moves is determined by two factors:
        // 1. The maximum number of dresses any single machine has in excess
        //    (machines[i] - target). This machine must shed these dresses,
        //    which takes 'diff' moves.
        maxMoves = max(maxMoves, diff);

        // 2. The maximum absolute balance encountered. This represents the
        //    largest amount of dresses that must pass through any single
        //    imaginary boundary between two machines.
        maxMoves = max(maxMoves, abs(balance));
    }

    return maxMoves;
}