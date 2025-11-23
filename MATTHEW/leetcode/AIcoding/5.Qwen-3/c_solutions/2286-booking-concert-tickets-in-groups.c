#include <stdio.h>
#include <stdlib.h>

int* createSortedArray(int* instructions, int instructionsSize, int* returnSize) {
    int* result = (int*)malloc(instructionsSize * sizeof(int));
    int* tree = (int*)calloc(100001, sizeof(int));

    int* temp = (int*)malloc(instructionsSize * sizeof(int));
    int idx = 0;

    for (int i = 0; i < instructionsSize; i++) {
        int val = instructions[i];
        int count = 0;

        int x = val - 1;
        while (x > 0) {
            count += tree[x];
            x -= x & -x;
        }

        x = val;
        while (x <= 100000) {
            tree[x] += 1;
            x += x & -x;
        }

        result[i] = count;
    }

    *returnSize = instructionsSize;
    return result;
}