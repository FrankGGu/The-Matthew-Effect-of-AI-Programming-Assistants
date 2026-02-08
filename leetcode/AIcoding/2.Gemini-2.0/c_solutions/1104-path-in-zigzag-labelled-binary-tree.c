#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* pathInZigZagTree(int label, int* returnSize) {
    int level = 0;
    int temp = label;
    while (temp > 0) {
        level++;
        temp /= 2;
    }

    int* path = (int*)malloc(sizeof(int) * level);
    *returnSize = level;
    path[level - 1] = label;

    for (int i = level - 2; i >= 0; i--) {
        int parent = label / 2;
        int max_val = (1 << (i + 1)) - 1;
        int min_val = (1 << i);
        parent = max_val - (parent - min_val);
        path[i] = parent;
        label = parent;
    }

    return path;
}