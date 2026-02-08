#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isSquareful(int a, int b) {
    int sum = a + b;
    int root = (int)sqrt(sum);
    return root * root == sum;
}

void backtrack(int* nums, int size, int* visited, int* path, int pathSize, int* result) {
    if (pathSize == size) {
        (*result)++;
        return;
    }

    for (int i = 0; i < size; i++) {
        if (visited[i]) continue;
        if (pathSize > 0 && !isSquareful(path[pathSize - 1], nums[i])) continue;
        visited[i] = 1;
        path[pathSize] = nums[i];
        backtrack(nums, size, visited, path, pathSize + 1, result);
        visited[i] = 0;
    }
}

int numSquarefulPerms(int* nums, int numsSize) {
    int* visited = (int*)calloc(numsSize, sizeof(int));
    int* path = (int*)malloc(numsSize * sizeof(int));
    int result = 0;
    qsort(nums, numsSize, sizeof(int), (int(*)(const void*, const void*))strcmp);
    backtrack(nums, numsSize, visited, path, 0, &result);
    free(visited);
    free(path);
    return result;
}