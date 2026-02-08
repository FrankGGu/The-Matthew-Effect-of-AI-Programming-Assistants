typedef struct {
    int profit;
    int category;
} Item;

int cmp(const void* a, const void* b) {
    Item* itemA = (Item*)a;
    Item* itemB = (Item*)b;
    return itemB->profit - itemA->profit;
}

long long findMaximumElegance(int** items, int itemsSize, int* itemsColSize, int k) {
    Item* arr = (Item*)malloc(itemsSize * sizeof(Item));
    for (int i = 0; i < itemsSize; i++) {
        arr[i].profit = items[i][0];
        arr[i].category = items[i][1];
    }

    qsort(arr, itemsSize, sizeof(Item), cmp);

    long long totalProfit = 0;
    int* categoryCount = (int*)calloc(itemsSize + 1, sizeof(int));
    int uniqueCategories = 0;

    int* duplicates = (int*)malloc(k * sizeof(int));
    int dupCount = 0;

    for (int i = 0; i < k; i++) {
        totalProfit += arr[i].profit;
        if (categoryCount[arr[i].category] == 0) {
            uniqueCategories++;
        }
        categoryCount[arr[i].category]++;
    }

    for (int i = k - 1; i >= 0; i--) {
        if (categoryCount[arr[i].category] > 1) {
            duplicates[dupCount++] = arr[i].profit;
            categoryCount[arr[i].category]--;
        }
    }

    long long maxElegance = totalProfit + (long long)uniqueCategories * uniqueCategories;

    for (int i = k; i < itemsSize && dupCount > 0; i++) {
        if (categoryCount[arr[i].category] == 0) {
            totalProfit = totalProfit - duplicates[--dupCount] + arr[i].profit;
            uniqueCategories++;
            categoryCount[arr[i].category]++;
            long long elegance = totalProfit + (long long)uniqueCategories * uniqueCategories;
            if (elegance > maxElegance) {
                maxElegance = elegance;
            }
        }
    }

    free(arr);
    free(categoryCount);
    free(duplicates);

    return maxElegance;
}