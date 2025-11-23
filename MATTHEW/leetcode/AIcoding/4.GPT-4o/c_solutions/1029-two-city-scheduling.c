int twoCitySchedCost(int** costs, int costsSize, int* costsColSize) {
    int n = costsSize / 2;
    int* diff = (int*)malloc(costsSize * sizeof(int));
    for (int i = 0; i < costsSize; i++) {
        diff[i] = costs[i][0] - costs[i][1];
    }
    qsort(diff, costsSize, sizeof(int), cmp);
    int totalCost = 0;
    for (int i = 0; i < n; i++) {
        totalCost += costs[i][0];
    }
    for (int i = n; i < costsSize; i++) {
        totalCost += costs[i][1];
    }
    free(diff);
    return totalCost;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}