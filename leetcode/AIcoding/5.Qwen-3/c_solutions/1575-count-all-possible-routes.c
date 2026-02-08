#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int** dp;
    int n;
} Solution;

Solution* solutionCreate(int* locations, int locationsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->n = locationsSize;
    obj->dp = (int**)malloc(locationsSize * sizeof(int*));
    for (int i = 0; i < locationsSize; i++) {
        obj->dp[i] = (int*)malloc(locationsSize * sizeof(int));
        memset(obj->dp[i], -1, locationsSize * sizeof(int));
    }
    return obj;
}

int dfs(Solution* obj, int current, int finish, int fuel, int* locations) {
    if (obj->dp[current][fuel] != -1) {
        return obj->dp[current][fuel];
    }
    int res = 0;
    if (current == finish) {
        res++;
    }
    for (int next = 0; next < obj->n; next++) {
        if (next != current && fuel >= abs(locations[current] - locations[next])) {
            res += dfs(obj, next, finish, fuel - abs(locations[current] - locations[next]), locations);
        }
    }
    obj->dp[current][fuel] = res;
    return res;
}

int countRoutes(int* locations, int locationsSize, int start, int finish, int fuel) {
    Solution* obj = solutionCreate(locations, locationsSize);
    int result = dfs(obj, start, finish, fuel, locations);
    for (int i = 0; i < locationsSize; i++) {
        free(obj->dp[i]);
    }
    free(obj->dp);
    free(obj);
    return result;
}