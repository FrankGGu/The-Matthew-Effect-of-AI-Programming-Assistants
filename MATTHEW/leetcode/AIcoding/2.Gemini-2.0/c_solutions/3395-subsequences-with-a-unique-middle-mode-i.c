#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int uniqueSubsequences(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < (1 << numsSize); i++) {
        int subSize = 0;
        int sub[numsSize];
        for (int j = 0; j < numsSize; j++) {
            if ((i >> j) & 1) {
                sub[subSize++] = nums[j];
            }
        }
        if (subSize % 2 == 1 && subSize > 0) {
            int middle = subSize / 2;
            int mode = sub[middle];
            int isUnique = 1;
            for (int k = 0; k < subSize; k++) {
                if (k != middle) {
                    int currentCount = 0;
                    int modeCount = 0;
                    for(int l = 0; l < subSize; l++) {
                        if(sub[k] == sub[l]) currentCount++;
                        if(mode == sub[l]) modeCount++;
                    }
                    if(currentCount > modeCount) {
                        isUnique = 0;
                        break;
                    } else if (currentCount == modeCount && sub[k] != mode) {
                        isUnique = 0;
                        break;
                    }
                }
            }
            if (isUnique) {
                count++;
            }
        }
    }
    return count;
}