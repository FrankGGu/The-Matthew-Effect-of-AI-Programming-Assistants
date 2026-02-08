int minCost(char* colors, int* neededTime, int neededTimeSize) {
    int totalCost = 0, maxCost = 0;
    for (int i = 0; i < neededTimeSize; i++) {
        if (i > 0 && colors[i] == colors[i - 1]) {
            totalCost += (neededTime[i] < neededTime[i - 1]) ? neededTime[i] : neededTime[i - 1];
            maxCost = (neededTime[i] > neededTime[i - 1]) ? neededTime[i] : neededTime[i - 1];
        } else {
            totalCost += maxCost;
            maxCost = neededTime[i];
        }
    }
    totalCost += maxCost;
    return totalCost;
}