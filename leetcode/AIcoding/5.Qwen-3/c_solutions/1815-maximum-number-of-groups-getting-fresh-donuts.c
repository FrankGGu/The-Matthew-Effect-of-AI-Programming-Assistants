#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maxGroups;
int maxGroupsSize;
int* groupSizes;
int groupSizesSize;

void backtrack(int index, int* current, int currentSize, int* result, int* resultSize) {
    if (index == groupSizesSize) {
        if (currentSize > *resultSize) {
            *resultSize = currentSize;
            memcpy(result, current, currentSize * sizeof(int));
        }
        return;
    }

    int count = 0;
    for (int i = 0; i < groupSizesSize; i++) {
        if (groupSizes[i] == 0) continue;
        if (maxGroups[groupSizes[i]] > 0) {
            count++;
        }
    }

    if (count >= groupSizes[index]) {
        int temp[groupSizesSize];
        memcpy(temp, groupSizes, groupSizesSize * sizeof(int));
        for (int i = 0; i < groupSizesSize; i++) {
            if (groupSizes[i] == 0) continue;
            if (maxGroups[groupSizes[i]] > 0) {
                maxGroups[groupSizes[i]]--;
                groupSizes[i]--;
                current[currentSize] = i;
                backtrack(index + 1, current, currentSize + 1, result, resultSize);
                maxGroups[groupSizes[i]]++;
                groupSizes[i]++;
            }
        }
    } else {
        for (int i = 0; i < groupSizesSize; i++) {
            if (groupSizes[i] == 0) continue;
            if (maxGroups[groupSizes[i]] > 0) {
                maxGroups[groupSizes[i]]--;
                groupSizes[i]--;
                current[currentSize] = i;
                backtrack(index + 1, current, currentSize + 1, result, resultSize);
                maxGroups[groupSizes[i]]++;
                groupSizes[i]++;
            }
        }
    }
}

int* maxGroups(int* rest, int restSize, int* groupSizes, int groupSizesSize, int* returnSize) {
    maxGroups = (int*)malloc((restSize + 1) * sizeof(int));
    memset(maxGroups, 0, (restSize + 1) * sizeof(int));
    for (int i = 0; i < restSize; i++) {
        maxGroups[rest[i]]++;
    }
    groupSizesSize = groupSizesSize;
    groupSizes = (int*)malloc(groupSizesSize * sizeof(int));
    for (int i = 0; i < groupSizesSize; i++) {
        groupSizes[i] = groupSizes[i];
    }

    int* result = (int*)malloc(groupSizesSize * sizeof(int));
    int resultSize = 0;
    int* current = (int*)malloc(groupSizesSize * sizeof(int));

    backtrack(0, current, 0, result, &resultSize);

    *returnSize = resultSize;
    free(current);
    free(groupSizes);
    free(maxGroups);
    return result;
}