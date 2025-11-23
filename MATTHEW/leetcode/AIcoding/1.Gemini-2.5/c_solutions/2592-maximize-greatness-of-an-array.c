#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximizeGreatness(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int greatness = 0;
    int i = 0; 
    int j = 0; 

    while (j < numsSize) {
        if (nums[j] > nums[i]) {
            greatness++;
            i++; 
        }
        j++; 
    }

    return greatness;
}