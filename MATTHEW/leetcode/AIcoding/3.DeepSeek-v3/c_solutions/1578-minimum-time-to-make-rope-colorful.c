int minCost(char* colors, int* neededTime, int neededTimeSize) {
    int totalTime = 0;
    int maxTime = neededTime[0];
    int sumTime = neededTime[0];

    for (int i = 1; i < neededTimeSize; i++) {
        if (colors[i] == colors[i-1]) {
            maxTime = (neededTime[i] > maxTime) ? neededTime[i] : maxTime;
            sumTime += neededTime[i];
        } else {
            totalTime += (sumTime - maxTime);
            maxTime = neededTime[i];
            sumTime = neededTime[i];
        }
    }

    totalTime += (sumTime - maxTime);
    return totalTime;
}