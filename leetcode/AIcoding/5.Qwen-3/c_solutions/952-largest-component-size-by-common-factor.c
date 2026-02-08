#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_NUM 100000

int* parent;
int* rank;

int find(int x) {
    if (parent[x] != x)
        parent[x] = find(parent[x]);
    return parent[x];
}

void union_set(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);
    if (rootX != rootY) {
        if (rank[rootX] > rank[rootY])
            parent[rootY] = rootX;
        else {
            parent[rootX] = rootY;
            if (rank[rootX] == rank[rootY])
                rank[rootY]++;
        }
    }
}

int maxComponentSize(int* nums, int numsSize) {
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum)
            maxNum = nums[i];
    }

    parent = (int*)malloc((maxNum + 1) * sizeof(int));
    rank = (int*)malloc((maxNum + 1) * sizeof(int));

    for (int i = 0; i <= maxNum; i++) {
        parent[i] = i;
        rank[i] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        for (int j = 2; j <= sqrt(num); j++) {
            if (num % j == 0) {
                union_set(num, j);
                union_set(num, num / j);
            }
        }
    }

    int* componentSize = (int*)calloc(maxNum + 1, sizeof(int));
    int maxSize = 0;

    for (int i = 0; i < numsSize; i++) {
        int root = find(nums[i]);
        componentSize[root]++;
        if (componentSize[root] > maxSize)
            maxSize = componentSize[root];
    }

    free(parent);
    free(rank);
    free(componentSize);

    return maxSize;
}