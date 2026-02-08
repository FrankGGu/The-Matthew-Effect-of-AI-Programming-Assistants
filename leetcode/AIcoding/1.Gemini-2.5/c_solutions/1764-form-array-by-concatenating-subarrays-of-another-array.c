#include <stdbool.h>

bool canChoose(int** groups, int groupsSize, int* groupsColSize, int* nums, int numsSize) {
    int nums_current_idx = 0;

    for (int g_idx = 0; g_idx < groupsSize; ++g_idx) {
        int* current_group = groups[g_idx];
        int current_group_len = groupsColSize[g_idx];
        bool group_found = false;

        for (int i = nums_current_idx; i <= numsSize - current_group_len; ++i) {
            bool match = true;
            for (int j = 0; j < current_group_len; ++j) {
                if (nums[i + j] != current_group[j]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                group_found = true;
                nums_current_idx = i + current_group_len;
                break;
            }
        }

        if (!group_found) {
            return false;
        }
    }

    return true;
}