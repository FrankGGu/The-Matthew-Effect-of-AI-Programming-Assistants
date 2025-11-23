int cmp(const void* a, const void* b) {
    int* pa = *(int**)a;
    int* pb = *(int**)b;
    return (pa[0] - pa[1]) - (pb[0] - pb[1]);
}

int twoCitySchedCost(int** costs, int costsSize, int* costsColSize) {
    qsort(costs, costsSize, sizeof(int*), cmp);
    int total = 0;
    for (int i = 0; i < costsSize; i++) {
        if (i < costsSize / 2) {
            total += costs[i][0];
        } else {
            total += costs[i][1];
        }
    }
    return total;
}