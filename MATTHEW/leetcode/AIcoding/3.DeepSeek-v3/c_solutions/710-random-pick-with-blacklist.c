#include <stdlib.h>
#include <time.h>

typedef struct {
    int size;
    int* blacklist;
    int blacklistSize;
    int* map;
} Solution;

Solution* solutionCreate(int n, int* blacklist, int blacklistSize) {
    srand(time(NULL));
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->size = n - blacklistSize;
    obj->blacklist = blacklist;
    obj->blacklistSize = blacklistSize;

    obj->map = (int*)malloc(sizeof(int) * blacklistSize);
    for (int i = 0; i < blacklistSize; i++) {
        obj->map[i] = -1;
    }

    int last = n - 1;
    for (int i = 0; i < blacklistSize; i++) {
        if (blacklist[i] >= obj->size) {
            continue;
        }
        while (1) {
            int found = 0;
            for (int j = 0; j < blacklistSize; j++) {
                if (blacklist[j] == last) {
                    found = 1;
                    break;
                }
            }
            if (found) {
                last--;
            } else {
                break;
            }
        }
        for (int j = 0; j < blacklistSize; j++) {
            if (blacklist[j] == blacklist[i]) {
                obj->map[j] = last;
                break;
            }
        }
        last--;
    }

    return obj;
}

int solutionPick(Solution* obj) {
    int r = rand() % obj->size;
    for (int i = 0; i < obj->blacklistSize; i++) {
        if (obj->blacklist[i] == r) {
            return obj->map[i];
        }
    }
    return r;
}

void solutionFree(Solution* obj) {
    free(obj->map);
    free(obj);
}

/**
 * Your Solution struct will be instantiated and called as such:
 * Solution* obj = solutionCreate(n, blacklist, blacklistSize);
 * int param_1 = solutionPick(obj);
 * solutionFree(obj);
 */