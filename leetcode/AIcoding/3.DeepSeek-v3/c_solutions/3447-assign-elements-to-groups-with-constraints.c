#include <stdlib.h>
#include <string.h>

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* assignElements(int groups, int* constraints, int constraintsSize, int* returnSize) {
    int* result = (int*)malloc(groups * sizeof(int));
    *returnSize = groups;
    memset(result, -1, groups * sizeof(int));

    int* used = (int*)calloc(constraintsSize, sizeof(int));

    for (int i = 0; i < constraintsSize; i++) {
        int c = constraints[i];
        if (c < groups && result[c] == -1) {
            result[c] = i;
            used[i] = 1;
        }
    }

    int idx = 0;
    for (int i = 0; i < groups; i++) {
        if (result[i] == -1) {
            while (idx < constraintsSize && used[idx]) {
                idx++;
            }
            if (idx < constraintsSize) {
                result[i] = idx;
                used[idx] = 1;
            }
        }
    }

    free(used);
    return result;
}