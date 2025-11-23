#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_CREATORS 10000
#define MAX_ID_LENGTH 11

typedef struct {
    char id[MAX_ID_LENGTH];
    long long views;
    int index;
} CreatorData;

int compareCreators(const void *a, const void *b) {
    CreatorData *creatorA = (CreatorData *)a;
    CreatorData *creatorB = (CreatorData *)b;

    if (creatorA->views != creatorB->views) {
        return (creatorA->views < creatorB->views) ? 1 : -1;
    } else {
        return strcmp(creatorA->id, creatorB->id);
    }
}

char **mostPopularCreator(char **creators, int creatorsSize, int *ids, int idsSize, int *returnSize) {
    CreatorData creatorMap[MAX_CREATORS];
    int creatorCount = 0;
    long long maxViews = 0;

    for (int i = 0; i < creatorsSize; i++) {
        int found = 0;
        for (int j = 0; j < creatorCount; j++) {
            if (strcmp(creators[i], creatorMap[j].id) == 0) {
                creatorMap[j].views += ids[i];
                found = 1;
                break;
            }
        }
        if (!found) {
            strcpy(creatorMap[creatorCount].id, creators[i]);
            creatorMap[creatorCount].views = ids[i];
            creatorMap[creatorCount].index = i;
            creatorCount++;
        }
    }

    qsort(creatorMap, creatorCount, sizeof(CreatorData), compareCreators);

    maxViews = creatorMap[0].views;
    int count = 0;
    for (int i = 0; i < creatorCount; i++) {
        if (creatorMap[i].views == maxViews) {
            count++;
        } else {
            break;
        }
    }

    char **result = (char **)malloc(count * sizeof(char *));
    for (int i = 0; i < count; i++) {
        result[i] = (char *)malloc(MAX_ID_LENGTH * sizeof(char));
        strcpy(result[i], creatorMap[i].id);
    }

    *returnSize = count;
    return result;
}