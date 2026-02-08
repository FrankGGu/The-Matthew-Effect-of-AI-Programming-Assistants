#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

void wiggleSort(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    memcpy(temp, nums, numsSize * sizeof(int));

    qsort(temp, numsSize, sizeof(int), compare);

    int mid = (numsSize - 1) / 2;
    int left_ptr = mid;
    int right_ptr = numsSize - 1;

    for (int i = 1; i < numsSize; i += 2) {
        nums[i] = temp[right_ptr--];
    }

    for (int i = 0; i < numsSize; i += 2) {
        nums[i] = temp[left_ptr--];
    }

    free(temp);
}