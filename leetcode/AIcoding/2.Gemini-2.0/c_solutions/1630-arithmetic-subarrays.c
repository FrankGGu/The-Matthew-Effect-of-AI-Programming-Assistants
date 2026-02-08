#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isArithmetic(int* nums, int start, int end) {
    if (end - start < 2) return true;
    int minVal = nums[start];
    int maxVal = nums[start];
    for (int i = start + 1; i <= end; i++) {
        if (nums[i] < minVal) minVal = nums[i];
        if (nums[i] > maxVal) maxVal = nums[i];
    }
    if (minVal == maxVal) {
        for(int i = start+1; i <= end; i++){
            if(nums[i] != minVal) return false;
        }
        return true;
    }

    if ((maxVal - minVal) % (end - start) != 0) return false;
    int diff = (maxVal - minVal) / (end - start);
    if (diff == 0) return false;

    bool* seen = (bool*)calloc(end - start + 1, sizeof(bool));
    for (int i = start; i <= end; i++) {
        if ((nums[i] - minVal) % diff != 0) {
            free(seen);
            return false;
        }
        int index = (nums[i] - minVal) / diff;
        if (index < 0 || index > end - start || seen[index]) {
            free(seen);
            return false;
        }
        seen[index] = true;
    }

    for (int i = 0; i <= end - start; i++) {
        if (!seen[i]) {
            free(seen);
            return false;
        }
    }

    free(seen);
    return true;
}

bool* checkArithmeticSubarrays(int* nums, int numsSize, int* l, int lSize, int* r, int rSize, int* returnSize){
    bool* result = (bool*)malloc(lSize * sizeof(bool));
    *returnSize = lSize;
    for (int i = 0; i < lSize; i++) {
        result[i] = isArithmetic(nums, l[i], r[i]);
    }
    return result;
}