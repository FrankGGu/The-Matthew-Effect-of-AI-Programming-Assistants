int canCompleteCircuit(int* gas, int gasSize, int* cost, int costSize) {
    int totalGas = 0, totalCost = 0, currentGas = 0, startIndex = 0;

    for (int i = 0; i < gasSize; i++) {
        totalGas += gas[i];
        totalCost += cost[i];
        currentGas += gas[i] - cost[i];

        if (currentGas < 0) {
            startIndex = i + 1;
            currentGas = 0;
        }
    }

    return totalGas >= totalCost ? startIndex : -1;
}