#include <stdlib.h>

typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashNode;

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int longestConsecutive(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    qsort(nums, numsSize, sizeof(int), cmp);

    int longest = 1;
    int current = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i-1]) {
            if (nums[i] == nums[i-1] + 1) {
                current++;
            } else {
                longest = (current > longest) ? current : longest;
                current = 1;
            }
        }
    }

    return (current > longest) ? current : longest;
}