int maximumSpending(int* costs, int costsSize, int coins) {
    int left = 0, right = costsSize - 1;
    int totalSpent = 0;

    // Sort the costs array
    qsort(costs, costsSize, sizeof(int), cmpfunc);

    for (int i = 0; i < costsSize; i++) {
        if (coins >= costs[i]) {
            totalSpent += costs[i];
            coins -= costs[i];
        } else {
            break;
        }
    }

    return totalSpent;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}