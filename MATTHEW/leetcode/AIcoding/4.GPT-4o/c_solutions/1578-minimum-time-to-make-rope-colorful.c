int minCost(char *colors, int *neededTime, int neededTimeSize) {
    int totalCost = 0, maxTime = 0;

    for (int i = 0; i < neededTimeSize; i++) {
        if (i > 0 && colors[i] == colors[i - 1]) {
            totalCost += fmax(0, neededTime[i] - maxTime);
            maxTime = fmax(maxTime, neededTime[i]);
        } else {
            maxTime = neededTime[i];
        }
    }

    return totalCost;
}