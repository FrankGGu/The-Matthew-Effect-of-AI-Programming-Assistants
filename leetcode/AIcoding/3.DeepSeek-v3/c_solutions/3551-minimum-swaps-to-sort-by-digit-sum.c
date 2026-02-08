#include <stdlib.h>
#include <string.h>

int digitSum(int num) {
    int sum = 0;
    while (num > 0) {
        sum += num % 10;
        num /= 10;
    }
    return sum;
}

int find(int* parent, int x) {
    if (parent[x] != x) {
        parent[x] = find(parent, parent[x]);
    }
    return parent[x];
}

void unionSets(int* parent, int* rank, int x, int y) {
    int rootX = find(parent, x);
    int rootY = find(parent, y);
    if (rootX != rootY) {
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else if (rank[rootX] > rank[rootY]) {
            parent[rootY] = rootX;
        } else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
    }
}

int cmp(const void* a, const void* b) {
    return digitSum(*(int*)a) - digitSum(*(int*)b);
}

int minimumSwaps(int* nums, int numsSize) {
    int* sortedNums = (int*)malloc(numsSize * sizeof(int));
    memcpy(sortedNums, nums, numsSize * sizeof(int));
    qsort(sortedNums, numsSize, sizeof(int), cmp);

    int* parent = (int*)malloc(numsSize * sizeof(int));
    int* rank = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        parent[i] = i;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (digitSum(nums[i]) == digitSum(nums[j])) {
                unionSets(parent, rank, i, j);
            }
        }
    }

    int* posMap = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (nums[i] == sortedNums[j]) {
                posMap[i] = j;
                break;
            }
        }
    }

    int swaps = 0;
    int* visited = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        if (visited[i] || posMap[i] == i) continue;

        int cycleSize = 0;
        int j = i;
        while (!visited[j]) {
            visited[j] = 1;
            j = posMap[j];
            cycleSize++;
        }

        if (cycleSize > 1) {
            swaps += cycleSize - 1;
        }
    }

    free(sortedNums);
    free(parent);
    free(rank);
    free(posMap);
    free(visited);

    return swaps;
}