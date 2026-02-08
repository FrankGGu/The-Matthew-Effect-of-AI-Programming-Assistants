#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int index;
} Node;

int cmp(const void *a, const void *b) {
    return ((Node*)a)->val - ((Node*)b)->val;
}

long long makeArrayEmpty(int* nums, int numsSize) {
    Node* nodes = (Node*)malloc(numsSize * sizeof(Node));
    for (int i = 0; i < numsSize; i++) {
        nodes[i].val = nums[i];
        nodes[i].index = i;
    }

    qsort(nodes, numsSize, sizeof(Node), cmp);

    long long result = 0;
    int currentPos = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nodes[i].index >= currentPos) {
            result += (long long)(nodes[i].index - currentPos + 1);
            currentPos = nodes[i].index + 1;
        } else {
            result += (long long)(numsSize - currentPos + nodes[i].index + 1);
            currentPos = nodes[i].index + 1;
        }
        currentPos %= numsSize;
    }

    free(nodes);
    return result;
}