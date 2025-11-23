#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int category1;
    int category2;
    int count;
} Result;

int compare(const void *a, const void *b) {
    Result *resultA = (Result *)a;
    Result *resultB = (Result *)b;
    if (resultA->count != resultB->count) {
        return resultB->count - resultA->count;
    } else if (resultA->category1 != resultB->category1) {
        return resultA->category1 - resultB->category1;
    } else {
        return resultA->category2 - resultB->category2;
    }
}

Result* findCategoryRecommendationPairs(int* category, int categorySize, int threshold, int* returnSize) {
    int* counts = (int*)malloc(categorySize * categorySize * sizeof(int));
    memset(counts, 0, categorySize * categorySize * sizeof(int));

    for (int i = 0; i < categorySize; i++) {
        for (int j = i + 1; j < categorySize; j++) {
            int dist = abs(category[i] - category[j]);
            if (dist <= threshold) {
                counts[i * categorySize + j]++;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < categorySize; i++) {
        for (int j = i + 1; j < categorySize; j++) {
            if (counts[i * categorySize + j] > 0) {
                count++;
            }
        }
    }

    Result* result = (Result*)malloc(count * sizeof(Result));
    *returnSize = 0;

    for (int i = 0; i < categorySize; i++) {
        for (int j = i + 1; j < categorySize; j++) {
            if (counts[i * categorySize + j] > 0) {
                result[*returnSize].category1 = category[i] < category[j] ? category[i] : category[j];
                result[*returnSize].category2 = category[i] < category[j] ? category[j] : category[i];
                result[*returnSize].count = counts[i * categorySize + j];
                (*returnSize)++;
            }
        }
    }

    qsort(result, *returnSize, sizeof(Result), compare);
    free(counts);
    return result;
}