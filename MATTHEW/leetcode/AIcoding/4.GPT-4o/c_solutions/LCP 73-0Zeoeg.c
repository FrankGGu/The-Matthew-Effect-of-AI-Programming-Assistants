int canCompleteCircuit(int* gas, int gasSize, int* cost, int costSize) {
    int totalTank = 0, currTank = 0, startingStation = 0;

    for (int i = 0; i < gasSize; i++) {
        totalTank += gas[i] - cost[i];
        currTank += gas[i] - cost[i];
        if (currTank < 0) {
            startingStation = i + 1;
            currTank = 0;
        }
    }

    return (totalTank >= 0) ? startingStation : -1;
}