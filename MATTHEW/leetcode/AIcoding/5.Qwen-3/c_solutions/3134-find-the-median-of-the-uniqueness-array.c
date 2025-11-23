#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int uniqueElements(int* nums, int numsSize, int** result) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int isUnique = 1;
        for (int j = 0; j < numsSize; j++) {
            if (i != j && nums[i] == nums[j]) {
                isUnique = 0;
                break;
            }
        }
        if (isUnique) {
            temp[count++] = nums[i];
        }
    }
    *result = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        (*result)[i] = temp[i];
    }
    free(temp);
    return count;
}

int findMedian(int* nums, int numsSize) {
    int* uniqueArr;
    int uniqueSize = uniqueElements(nums, numsSize, &uniqueArr);
    qsort(uniqueArr, uniqueSize, sizeof(int), compare);
    int median = uniqueArr[uniqueSize / 2];
    free(uniqueArr);
    return median;
}