#include <string.h>

int numOfPairs(char **nums, int numsSize, char *target) {
    int count = 0;
    int target_len = strlen(target);

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (i == j) {
                continue;
            }

            int len_i = strlen(nums[i]);
            int len_j = strlen(nums[j]);

            if (len_i + len_j == target_len) {
                if (strncmp(target, nums[i], len_i) == 0 &&
                    strcmp(target + len_i, nums[j]) == 0) {
                    count++;
                }
            }
        }
    }

    return count;
}