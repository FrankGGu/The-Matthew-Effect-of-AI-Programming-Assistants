#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int find(int parent[], int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent, parent[i]);
}

void unite(int parent[], int rank[], int x, int y) {
    int xroot = find(parent, x);
    int yroot = find(parent, y);

    if (xroot == yroot) {
        return;
    }

    if (rank[xroot] < rank[yroot]) {
        parent[xroot] = yroot;
    } else if (rank[xroot] > rank[yroot]) {
        parent[yroot] = xroot;
    } else {
        parent[yroot] = xroot;
        rank[xroot]++;
    }
}

bool gcdSort(int* nums, int numsSize) {
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    int* parent = (int*)malloc((maxVal + 1) * sizeof(int));
    int* rank = (int*)malloc((maxVal + 1) * sizeof(int));
    for (int i = 0; i <= maxVal; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 2; j * j <= nums[i]; j++) {
            if (nums[i] % j == 0) {
                unite(parent, rank, nums[i], j);
                unite(parent, rank, j, nums[i] / j);
            }
        }
        if (nums[i] > 1) {
            unite(parent, rank, nums[i], 1);
        }
    }

    int* sortedNums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sortedNums[i] = nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (sortedNums[i] > sortedNums[j]) {
                int temp = sortedNums[i];
                sortedNums[i] = sortedNums[j];
                sortedNums[j] = temp;
            }
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (find(parent, nums[i]) != find(parent, sortedNums[i])) {
            free(parent);
            free(rank);
            free(sortedNums);
            return false;
        }
    }

    free(parent);
    free(rank);
    free(sortedNums);
    return true;
}