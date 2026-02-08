#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int id;
    int count;
} IDCount;

int cmp(const void *a, const void *b) {
    IDCount *idCountA = (IDCount *)a;
    IDCount *idCountB = (IDCount *)b;
    if (idCountA->count != idCountB->count) {
        return idCountB->count - idCountA->count;
    }
    return idCountA->id - idCountB->id;
}

int* mostFrequentIDs(int* ids, int idsSize, int* returnSize) {
    int maxId = 0;
    for (int i = 0; i < idsSize; i++) {
        if (ids[i] > maxId) {
            maxId = ids[i];
        }
    }

    int* count = (int*)calloc(maxId + 1, sizeof(int));
    for (int i = 0; i < idsSize; i++) {
        count[ids[i]]++;
    }

    IDCount* idCounts = (IDCount*)malloc((maxId + 1) * sizeof(IDCount));
    int uniqueCount = 0;
    for (int i = 0; i <= maxId; i++) {
        if (count[i] > 0) {
            idCounts[uniqueCount].id = i;
            idCounts[uniqueCount].count = count[i];
            uniqueCount++;
        }
    }

    qsort(idCounts, uniqueCount, sizeof(IDCount), cmp);

    int maxFrequency = idCounts[0].count;
    *returnSize = 0;
    for (int i = 0; i < uniqueCount && idCounts[i].count == maxFrequency; i++) {
        (*returnSize)++;
    }

    int* result = (int*)malloc((*returnSize) * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = idCounts[i].id;
    }

    free(count);
    free(idCounts);
    return result;
}