#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef long long ll;

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maximumElegance(int* items, int itemsSize, int k) {
    int n = itemsSize;
    int** pairs = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        pairs[i] = (int*)malloc(2 * sizeof(int));
        pairs[i][0] = items[i];
        pairs[i][1] = i;
    }

    qsort(pairs, n, sizeof(int*), compare);

    int* values = (int*)malloc(k * sizeof(int));
    int* counts = (int*)calloc(n, sizeof(int));
    int uniqueCount = 0;
    long long elegance = 0;

    for (int i = 0; i < k; i++) {
        int val = pairs[i][0];
        values[i] = val;
        if (counts[val] == 0) {
            uniqueCount++;
        }
        counts[val]++;
        elegance += val;
    }

    qsort(values, k, sizeof(int), compare);

    for (int i = k; i < n; i++) {
        int val = pairs[i][0];
        if (uniqueCount < k && counts[val] == 0) {
            int replaceIndex = -1;
            for (int j = 0; j < k; j++) {
                if (counts[values[j]] > 1) {
                    replaceIndex = j;
                    break;
                }
            }
            if (replaceIndex != -1) {
                elegance -= values[replaceIndex];
                elegance += val;
                counts[values[replaceIndex]]--;
                counts[val]++;
                values[replaceIndex] = val;
                qsort(values, k, sizeof(int), compare);
                uniqueCount++;
            }
        }
    }

    free(values);
    free(counts);
    for (int i = 0; i < n; i++) {
        free(pairs[i]);
    }
    free(pairs);
    return elegance;
}