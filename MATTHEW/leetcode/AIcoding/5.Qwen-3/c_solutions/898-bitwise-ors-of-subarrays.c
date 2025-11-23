#include <stdio.h>
#include <stdlib.h>

int numSubseqsInRange(int* nums, int numsSize, int minK, int maxK) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < minK || nums[i] > maxK) continue;
        int min_val = nums[i], max_val = nums[i];
        for (int j = i; j < numsSize; j++) {
            if (nums[j] < minK || nums[j] > maxK) break;
            min_val = (nums[j] < min_val) ? nums[j] : min_val;
            max_val = (nums[j] > max_val) ? nums[j] : max_val;
            if (min_val == minK && max_val == maxK) count++;
        }
    }
    return count;
}

int uniqueSubseqs(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 0) continue;
        int min_val = nums[i], max_val = nums[i];
        for (int j = i; j < numsSize; j++) {
            if (nums[j] < 0) break;
            min_val = (nums[j] < min_val) ? nums[j] : min_val;
            max_val = (nums[j] > max_val) ? nums[j] : max_val;
            if (min_val == 0 && max_val == 0) count++;
        }
    }
    return count;
}

int subarrayBitwiseORs(int* nums, int numsSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int resultSize = 0;
    for (int i = 0; i < numsSize; i++) {
        int current = 0;
        for (int j = i; j < numsSize; j++) {
            current |= nums[j];
            int found = 0;
            for (int k = 0; k < resultSize; k++) {
                if (result[k] == current) {
                    found = 1;
                    break;
                }
            }
            if (!found) {
                result[resultSize++] = current;
            }
        }
    }
    int* output = (int*)malloc(resultSize * sizeof(int));
    for (int i = 0; i < resultSize; i++) {
        output[i] = result[i];
    }
    free(result);
    return resultSize;
}