#include <stdio.h>
#include <stdlib.h>

int* pathInZigzagLabelledBinaryTree(int label, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 32);
    int index = 0;
    int level = 0;
    while ((1 << level) <= label) {
        level++;
    }
    level--;
    while (label > 0) {
        result[index++] = label;
        int first = 1 << level;
        int last = (1 << (level + 1)) - 1;
        int mirrored = first + last - label;
        label = mirrored / 2;
        level--;
    }
    *returnSize = index;
    int* res = (int*)malloc(sizeof(int) * index);
    for (int i = 0; i < index; i++) {
        res[i] = result[index - 1 - i];
    }
    free(result);
    return res;
}