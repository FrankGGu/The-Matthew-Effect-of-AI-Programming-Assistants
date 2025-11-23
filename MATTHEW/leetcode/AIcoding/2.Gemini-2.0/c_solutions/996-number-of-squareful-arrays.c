#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

bool isPerfectSquare(int num) {
    if (num < 0) return false;
    if (num == 0) return true;
    int root = round(sqrt(num));
    return root * root == num;
}

int numSquarefulPerms(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int count = 0;
    int *perm = (int *)malloc(numsSize * sizeof(int));
    bool *used = (bool *)malloc(numsSize * sizeof(bool));
    for (int i = 0; i < numsSize; i++) {
        used[i] = false;
    }

    void backtrack(int index) {
        if (index == numsSize) {
            count++;
            return;
        }

        for (int i = 0; i < numsSize; i++) {
            if (used[i]) continue;

            if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) continue;

            if (index > 0 && !isPerfectSquare(perm[index - 1] + nums[i])) continue;

            perm[index] = nums[i];
            used[i] = true;
            backtrack(index + 1);
            used[i] = false;
        }
    }

    backtrack(0);

    free(perm);
    free(used);

    return count;
}