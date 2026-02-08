int maximumPopulation(int** logs, int logsSize, int* logsColSize) {
    int years[101] = {0};

    for (int i = 0; i < logsSize; i++) {
        years[logs[i][0] - 1950]++;
        years[logs[i][1] - 1950]--;
    }

    int maxPopulation = years[0];
    int maxYear = 1950;

    for (int i = 1; i < 101; i++) {
        years[i] += years[i - 1];
        if (years[i] > maxPopulation) {
            maxPopulation = years[i];
            maxYear = i + 1950;
        }
    }

    return maxYear;
}