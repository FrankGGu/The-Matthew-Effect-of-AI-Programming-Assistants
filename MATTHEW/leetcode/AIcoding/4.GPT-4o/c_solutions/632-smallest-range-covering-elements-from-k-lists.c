#include <stdlib.h>
#include <stdio.h>
#include <limits.h>

struct Node {
    int value;
    int listIndex;
    int elementIndex;
};

int cmp(const void *a, const void *b) {
    return ((struct Node *)a)->value - ((struct Node *)b)->value;
}

int* smallestRange(int** nums, int numsSize, int* numsColSize, int* returnSize) {
    int minRange = INT_MAX, start = 0, end = 0;
    int totalElements = 0;
    struct Node *nodes = (struct Node *)malloc(sizeof(struct Node) * 10000);

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsColSize[i]; j++) {
            nodes[totalElements++] = (struct Node){nums[i][j], i, j};
        }
    }

    qsort(nodes, totalElements, sizeof(struct Node), cmp);

    int count[numsSize];
    int uniqueCount = 0;
    int left = 0;

    for (int right = 0; right < totalElements; right++) {
        int listIdx = nodes[right].listIndex;
        if (count[listIdx] == 0) uniqueCount++;
        count[listIdx]++;

        while (uniqueCount == numsSize) {
            if (nodes[right].value - nodes[left].value < minRange) {
                minRange = nodes[right].value - nodes[left].value;
                start = nodes[left].value;
                end = nodes[right].value;
            }
            count[nodes[left].listIndex]--;
            if (count[nodes[left].listIndex] == 0) uniqueCount--;
            left++;
        }
    }

    int *result = (int *)malloc(sizeof(int) * 2);
    result[0] = start;
    result[1] = end;
    *returnSize = 2;
    free(nodes);
    return result;
}