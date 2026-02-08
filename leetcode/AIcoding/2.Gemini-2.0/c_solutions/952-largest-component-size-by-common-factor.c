#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int parent[], int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int size[], int i, int j) {
    int rootI = find(parent, i);
    int rootJ = find(parent, j);
    if (rootI != rootJ) {
        if (size[rootI] < size[rootJ]) {
            parent[rootI] = rootJ;
            size[rootJ] += size[rootI];
        } else {
            parent[rootJ] = rootI;
            size[rootI] += size[rootJ];
        }
    }
}

int largestComponentSize(int* nums, int numsSize){
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    int* parent = (int*)malloc((maxVal + 1) * sizeof(int));
    int* size = (int*)malloc((maxVal + 1) * sizeof(int));

    for (int i = 0; i <= maxVal; i++) {
        parent[i] = i;
        size[i] = 1;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 2; j * j <= nums[i]; j++) {
            if (nums[i] % j == 0) {
                unite(parent, size, nums[i], j);
                unite(parent, size, nums[i], nums[i] / j);
            }
        }
        if (nums[i] > 1) {
            unite(parent, size, nums[i], 1);
        }
    }

    int* count = (int*)calloc(maxVal + 1, sizeof(int));
    int largest = 0;
    for (int i = 0; i < numsSize; i++) {
        int root = find(parent, nums[i]);
        count[root]++;
        if (count[root] > largest) {
            largest = count[root];
        }
    }

    free(parent);
    free(size);
    free(count);

    return largest;
}