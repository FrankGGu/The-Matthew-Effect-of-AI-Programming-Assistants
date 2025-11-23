#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return *(int *)b - *(int *)a;
}

int maxProfit(int* inventory, int inventorySize, int orders) {
    qsort(inventory, inventorySize, sizeof(int), cmp);

    long long totalProfit = 0;
    long long mod = 1000000007;

    for (int i = 0; i < inventorySize && orders > 0; i++) {
        if (i < inventorySize - 1) {
            long long count = inventory[i] - inventory[i + 1];
            long long sellCount = count * (i + 1);
            if (orders >= sellCount) {
                totalProfit = (totalProfit + (long long)(inventory[i] + inventory[i + 1] + 1) * count / 2 * (i + 1)) % mod;
                orders -= sellCount;
            } else {
                long long fullSets = orders / (i + 1);
                long long remainder = orders % (i + 1);
                totalProfit = (totalProfit + (long long)(inventory[i] + (inventory[i] - fullSets) + 1) * fullSets / 2 * (i + 1)) % mod;
                totalProfit = (totalProfit + remainder * (inventory[i] - fullSets)) % mod;
                orders = 0;
            }
        } else {
            long long fullSets = orders / (i + 1);
            long long remainder = orders % (i + 1);
            totalProfit = (totalProfit + (long long)(inventory[i] + (inventory[i] - fullSets) + 1) * fullSets / 2 * (i + 1)) % mod;
            totalProfit = (totalProfit + remainder * (inventory[i] - fullSets)) % mod;
            orders = 0;
        }
    }

    return (int)(totalProfit % mod);
}