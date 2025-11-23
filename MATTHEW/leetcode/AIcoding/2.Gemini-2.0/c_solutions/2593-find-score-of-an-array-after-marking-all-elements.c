#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int index;
    int value;
} Element;

int compare(const void *a, const void *b) {
    return ((Element *)a)->value - ((Element *)b)->value;
}

long long findScore(int* nums, int numsSize){
    Element elements[numsSize];
    for (int i = 0; i < numsSize; i++) {
        elements[i].index = i;
        elements[i].value = nums[i];
    }

    qsort(elements, numsSize, sizeof(Element), compare);

    long long score = 0;
    int marked[numsSize];
    for (int i = 0; i < numsSize; i++) {
        marked[i] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        int index = elements[i].index;
        if (marked[index] == 0) {
            score += elements[i].value;
            marked[index] = 1;
            if (index > 0) {
                marked[index - 1] = 1;
            }
            if (index < numsSize - 1) {
                marked[index + 1] = 1;
            }
        }
    }

    return score;
}