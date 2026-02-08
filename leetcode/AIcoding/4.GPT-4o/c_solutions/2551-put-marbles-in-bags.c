int putMarbles(int* weights, int weightsSize, int bags) {
    int* sortedWeights = (int*)malloc(weightsSize * sizeof(int));
    for (int i = 0; i < weightsSize; i++) {
        sortedWeights[i] = weights[i];
    }
    qsort(sortedWeights, weightsSize, sizeof(int), cmp);
    int minWeight = 0, maxWeight = 0;

    for (int i = 0; i < bags - 1; i++) {
        minWeight += sortedWeights[i];
        maxWeight += sortedWeights[weightsSize - 1 - i];
    }

    free(sortedWeights);
    return maxWeight - minWeight;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a) - (*(int*)b);
}