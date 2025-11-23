int findMinMoves(int* machines, int machinesSize) {
    int total = 0, maxLoad = 0;
    for (int i = 0; i < machinesSize; i++) {
        total += machines[i];
        if (machines[i] > maxLoad) {
            maxLoad = machines[i];
        }
    }
    if (total % machinesSize != 0) return -1;
    int target = total / machinesSize, maxMoves = 0, currentSum = 0;
    for (int i = 0; i < machinesSize; i++) {
        currentSum += machines[i] - target;
        maxMoves = currentSum > maxMoves ? currentSum : maxMoves;
        maxMoves = maxMoves > machines[i] ? maxMoves : machines[i];
    }
    return maxMoves;
}