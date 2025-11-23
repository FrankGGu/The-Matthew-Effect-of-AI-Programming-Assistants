#include <stdlib.h>
#include <stdio.h>

char* optimalDivision(int* nums, int numsSize) {
    char* result = (char*)malloc(sizeof(char) * 5000); 
    if (result == NULL) {
        return NULL;
    }

    char* current_pos = result;

    if (numsSize == 1) {
        current_pos += sprintf(current_pos, "%d", nums[0]);
    } else if (numsSize == 2) {
        current_pos += sprintf(current_pos, "%d/%d", nums[0], nums[1]);
    } else {
        current_pos += sprintf(current_pos, "%d/(", nums[0]);

        for (int i = 1; i < numsSize; i++) {
            current_pos += sprintf(current_pos, "%d", nums[i]);
            if (i < numsSize - 1) {
                current_pos += sprintf(current_pos, "/");
            }
        }

        current_pos += sprintf(current_pos, ")");
    }

    return result;
}