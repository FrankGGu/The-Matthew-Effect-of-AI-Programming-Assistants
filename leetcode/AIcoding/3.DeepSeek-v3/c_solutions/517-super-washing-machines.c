int findMinMoves(int* machines, int machinesSize) {
    int total = 0;
    for (int i = 0; i < machinesSize; i++) {
        total += machines[i];
    }

    if (total % machinesSize != 0) {
        return -1;
    }

    int target = total / machinesSize;
    int moves = 0;
    int balance = 0;

    for (int i = 0; i < machinesSize; i++) {
        balance += machines[i] - target;
        moves = fmax(moves, fmax(machines[i] - target, fabs(balance)));
    }

    return moves;
}