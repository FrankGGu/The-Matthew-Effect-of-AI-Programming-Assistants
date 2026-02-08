int maximumPopulation(int** logs, int logsSize, int* logsColSize) {
    int population[2050] = {0};

    for (int i = 0; i < logsSize; i++) {
        population[logs[i][0]]++;
        population[logs[i][1]]--;
    }

    int maxYear = 1950, maxPop = 0, currentPop = 0;

    for (int year = 1950; year <= 2050; year++) {
        currentPop += population[year];
        if (currentPop > maxPop) {
            maxPop = currentPop;
            maxYear = year;
        }
    }

    return maxYear;
}