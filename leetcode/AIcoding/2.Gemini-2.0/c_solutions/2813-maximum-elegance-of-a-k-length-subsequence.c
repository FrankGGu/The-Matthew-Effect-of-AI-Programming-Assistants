#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int profit;
    int category;
} Item;

int compare(const void *a, const void *b) {
    return ((Item *)b)->profit - ((Item *)a)->profit;
}

long long findMaximumElegance(int** items, int itemsSize, int* itemsColSize, int k) {
    Item arr[itemsSize];
    for (int i = 0; i < itemsSize; i++) {
        arr[i].profit = items[i][0];
        arr[i].category = items[i][1];
    }

    qsort(arr, itemsSize, sizeof(Item), compare);

    long long totalProfit = 0;
    int categories[100001] = {0};
    int distinctCategories = 0;
    Item extras[itemsSize];
    int extrasSize = 0;

    for (int i = 0; i < k; i++) {
        totalProfit += arr[i].profit;
        if (categories[arr[i].category] == 0) {
            distinctCategories++;
        }
        categories[arr[i].category]++;
    }

    long long maxElegance = totalProfit + (long long)distinctCategories * distinctCategories;

    for (int i = k; i < itemsSize; i++) {
        extras[extrasSize++] = arr[i];
    }

    for (int i = k - 1; i >= 0; i--) {
        if (categories[arr[i].category] > 1) {
            categories[arr[i].category]--;
            totalProfit -= arr[i].profit;

            int foundReplacement = 0;
            for (int j = 0; j < extrasSize; j++) {
                if (categories[extras[j].category] == 0) {
                    totalProfit += extras[j].profit;
                    distinctCategories++;
                    categories[extras[j].category]++;
                    extras[j].profit = -1;
                    foundReplacement = 1;
                    break;
                }
            }
            if (!foundReplacement) break;

            long long currentElegance = totalProfit + (long long)distinctCategories * distinctCategories;
            if (currentElegance > maxElegance) {
                maxElegance = currentElegance;
            }
        }
    }

    return maxElegance;
}