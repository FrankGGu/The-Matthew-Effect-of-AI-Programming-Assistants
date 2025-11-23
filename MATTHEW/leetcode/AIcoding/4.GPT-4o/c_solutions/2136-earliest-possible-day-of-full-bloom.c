int earliestFullBloom(int* plantTime, int plantSize, int* growTime, int growSize) {
    int** plants = (int**)malloc(plantSize * sizeof(int*));
    for (int i = 0; i < plantSize; i++) {
        plants[i] = (int*)malloc(2 * sizeof(int));
        plants[i][0] = growTime[i];
        plants[i][1] = plantTime[i];
    }

    qsort(plants, plantSize, sizeof(int*), [](const void* a, const void* b) {
        return (*(int**)b)[0] - (*(int**)a)[0];
    });

    int currentTime = 0, maxBloomDay = 0;
    for (int i = 0; i < plantSize; i++) {
        currentTime += plants[i][1];
        maxBloomDay = fmax(maxBloomDay, currentTime + plants[i][0]);
    }

    for (int i = 0; i < plantSize; i++) {
        free(plants[i]);
    }
    free(plants);

    return maxBloomDay;
}