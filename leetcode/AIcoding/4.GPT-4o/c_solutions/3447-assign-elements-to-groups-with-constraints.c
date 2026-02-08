#include <stdbool.h>
#include <stdlib.h>

bool canAssign(int* nums, int numsSize, int** groups, int groupsSize, int* groupSizes) {
    int* groupCount = (int*)calloc(groupsSize, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        bool found = false;
        for (int j = 0; j < groupsSize; j++) {
            if (groupCount[j] < groupSizes[j]) {
                groupCount[j]++;
                found = true;
                break;
            }
        }
        if (!found) {
            free(groupCount);
            return false;
        }
    }
    free(groupCount);
    return true;
}

bool canAssignElements(int* nums, int numsSize, int** groups, int groupsSize, int* groupSizes) {
    return canAssign(nums, numsSize, groups, groupsSize, groupSizes);
}