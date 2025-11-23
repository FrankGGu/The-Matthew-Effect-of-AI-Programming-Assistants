int maximumPopulation(int** logs, int logsSize, int* logsColSize) {
    const int MIN_YEAR = 1950;
    const int MAX_YEAR = 2050;
    const int YEAR_ARRAY_SIZE = MAX_YEAR - MIN_YEAR + 1;

    int population_changes[YEAR_ARRAY_SIZE];
    for (int i = 0; i < YEAR_ARRAY_SIZE; ++i) {
        population_changes[i] = 0;
    }

    for (int i = 0; i < logsSize; ++i) {
        int birth_year = logs[i][0];
        int death_year = logs[i][1];

        population_changes[birth_year - MIN_YEAR]++;
        population_changes[death_year - MIN_YEAR]--;
    }

    int current_population = 0;
    int max_population = 0;
    int max_population_year = MIN_YEAR;

    for (int year = MIN_YEAR; year <= MAX_YEAR; ++year) {
        int index = year - MIN_YEAR;
        current_population += population_changes[index];

        if (current_population > max_population) {
            max_population = current_population;
            max_population_year = year;
        }
    }

    return max_population_year;
}