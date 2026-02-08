#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int size[], int a, int b) {
    a = find(parent, a);
    b = find(parent, b);
    if (a != b) {
        if (size[a] < size[b]) {
            int temp = a;
            a = b;
            b = temp;
        }
        parent[b] = a;
        size[a] += size[b];
    }
}

int* smallestLexico(int* nums, int numsSize, int limit, int* returnSize) {
    int* parent = (int*)malloc(numsSize * sizeof(int));
    int* size = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        parent[i] = i;
        size[i] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (abs(nums[i] - nums[j]) <= limit) {
                unite(parent, size, i, j);
            }
        }
    }

    int* groups[numsSize];
    int groupSizes[numsSize];
    for (int i = 0; i < numsSize; i++) {
        groups[i] = NULL;
        groupSizes[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        int root = find(parent, i);
        if (groups[root] == NULL) {
            groups[root] = (int*)malloc(numsSize * sizeof(int));
        }
        groups[root][groupSizes[root]++] = i;
    }

    for (int i = 0; i < numsSize; i++) {
        if (groups[i] != NULL) {
            int groupSize = groupSizes[i];
            int* groupValues = (int*)malloc(groupSize * sizeof(int));
            for (int j = 0; j < groupSize; j++) {
                groupValues[j] = nums[groups[i][j]];
            }

            for (int j = 0; j < groupSize; j++) {
                for (int k = j + 1; k < groupSize; k++) {
                    if (groupValues[j] > groupValues[k]) {
                        int temp = groupValues[j];
                        groupValues[j] = groupValues[k];
                        groupValues[k] = temp;
                    }
                }
            }

            for (int j = 0; j < groupSize; j++) {
                nums[groups[i][j]] = groupValues[j];
            }
            free(groupValues);
            free(groups[i]);
        }
    }

    free(parent);
    free(size);
    *returnSize = numsSize;
    return nums;
}