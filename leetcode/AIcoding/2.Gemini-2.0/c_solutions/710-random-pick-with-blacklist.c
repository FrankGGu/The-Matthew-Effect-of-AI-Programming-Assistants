#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int N;
    int blacklistSize;
    int* blacklist;
    int* map;
    int mappedSize;
} Solution;

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

Solution* solutionCreate(int n, int* blacklist, int blacklistSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->N = n;
    obj->blacklistSize = blacklistSize;
    obj->blacklist = (int*)malloc(sizeof(int) * blacklistSize);
    for (int i = 0; i < blacklistSize; i++) {
        obj->blacklist[i] = blacklist[i];
    }

    qsort(obj->blacklist, blacklistSize, sizeof(int), cmpfunc);

    obj->map = (int*)malloc(sizeof(int) * blacklistSize);
    obj->mappedSize = 0;

    int w = n - blacklistSize;
    int j = 0;
    for (int i = 0; i < blacklistSize; i++) {
        if (obj->blacklist[i] < w) {
            while (j < blacklistSize && obj->blacklist[j] >= w) {
                j++;
            }

            if (j < blacklistSize) {
                obj->map[obj->mappedSize++] = obj->blacklist[i];
                while (j < blacklistSize && obj->blacklist[j] >= w) {
                    j++;
                }
            } else {
                obj->map[obj->mappedSize++] = obj->blacklist[i];
            }

            int candidate = n - 1;
            while (j < blacklistSize && candidate == obj->blacklist[j]) {
                candidate--;
                j++;
            }
            obj->blacklist[i] = candidate;
            if(j > 0) j--;

        }
    }

    return obj;
}

int solutionPick(Solution* obj) {
    int w = obj->N - obj->blacklistSize;
    int r = rand() % w;

    int low = 0, high = obj->mappedSize - 1;
    int ans = r;

    while(low <= high){
        int mid = low + (high - low) / 2;
        if(obj->map[mid] <= r){
            low = mid + 1;
        } else {
            ans = r;
            high = mid - 1;
        }
    }

    for(int i = 0; i < obj->mappedSize; i++){
        if(obj->map[i] == r){
            r = obj->blacklist[i];
            return r;
        }
    }
    return r;
}

void solutionFree(Solution* obj) {
    free(obj->blacklist);
    free(obj->map);
    free(obj);
}