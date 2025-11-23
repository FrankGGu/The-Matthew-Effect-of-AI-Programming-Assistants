#include <stdlib.h>

typedef struct {
    int n;
    int* blackListMap;
    int blackListSize;
} Solution;

Solution* solutionCreate(int n, int* blacklist, int blacklistSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->n = n;
    obj->blackListSize = blacklistSize;
    obj->blackListMap = (int*)malloc(blacklistSize * sizeof(int));
    for (int i = 0; i < blacklistSize; i++) {
        obj->blackListMap[i] = blacklist[i];
    }

    int m = n - blacklistSize;
    int validIndex = m;
    for (int i = 0; i < blacklistSize; i++) {
        if (blacklist[i] >= m) {
            while (validIndex + blacklistSize < n && (blacklistMap[validIndex - m] != validIndex)) {
                validIndex++;
            }
            if (validIndex < n) {
                obj->blackListMap[i] = validIndex++;
            }
        }
    }
    return obj;
}

int solutionPick(Solution* obj) {
    int index = rand() % (obj->n - obj->blackListSize);
    for (int i = 0; i < obj->blackListSize; i++) {
        if (obj->blackListMap[i] <= index) {
            index++;
        }
    }
    return index;
}

void solutionFree(Solution* obj) {
    free(obj->blackListMap);
    free(obj);
}