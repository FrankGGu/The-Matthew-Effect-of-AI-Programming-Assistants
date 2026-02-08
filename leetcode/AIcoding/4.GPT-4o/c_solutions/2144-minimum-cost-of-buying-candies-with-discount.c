int minimumCost(int* cost, int costSize) {
    int totalCost = 0;
    qsort(cost, costSize, sizeof(int), cmp);
    for (int i = 0; i < costSize; i++) {
        if ((i % 3) != 2) {
            totalCost += cost[i];
        }
    }
    return totalCost;
}

int cmp(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}