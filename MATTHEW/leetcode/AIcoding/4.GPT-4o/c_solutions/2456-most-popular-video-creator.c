#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* creator;
    long long views;
} Creator;

int cmp(const void* a, const void* b) {
    Creator* creatorA = (Creator*)a;
    Creator* creatorB = (Creator*)b;
    if (creatorA->views == creatorB->views) {
        return strcmp(creatorA->creator, creatorB->creator);
    }
    return creatorB->views - creatorA->views;
}

char** mostPopularCreator(char** creators, int creatorsSize, char** ids, int idsSize, int* returnSize) {
    long long* views = (long long*)calloc(creatorsSize, sizeof(long long));
    long long* maxViews = (long long*)calloc(creatorsSize, sizeof(long long));
    char** mostPopular = (char**)malloc(creatorsSize * sizeof(char*));
    int* count = (int*)calloc(creatorsSize, sizeof(int));

    for (int i = 0; i < idsSize; i++) {
        int index = -1;
        for (int j = 0; j < creatorsSize; j++) {
            if (strcmp(creators[j], creators[i]) == 0) {
                index = j;
                break;
            }
        }
        views[index] += rand() % 1000 + 1; // Randomly generated views for testing
        count[index]++;
        if (views[index] > maxViews[index]) {
            maxViews[index] = views[index];
        }
    }

    Creator* creatorList = (Creator*)malloc(creatorsSize * sizeof(Creator));
    for (int i = 0; i < creatorsSize; i++) {
        creatorList[i].creator = creators[i];
        creatorList[i].views = views[i];
    }

    qsort(creatorList, creatorsSize, sizeof(Creator), cmp);

    *returnSize = 0;
    for (int i = 0; i < creatorsSize; i++) {
        if (creatorList[i].views == creatorList[0].views) {
            mostPopular[*returnSize] = creatorList[i].creator;
            (*returnSize)++;
        }
    }

    free(views);
    free(maxViews);
    free(count);
    free(creatorList);

    return mostPopular;
}