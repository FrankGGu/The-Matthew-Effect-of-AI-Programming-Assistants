/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* sortJumbled(int* mapping, int mappingSize, int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    if (numsSize == 0) return result;

    // Create an array to store mapped values and original indices
    int** mapped = (int**)malloc(numsSize * sizeof(int*));
    for (int i = 0; i < numsSize; i++) {
        mapped[i] = (int*)malloc(2 * sizeof(int));
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int mappedValue = 0;
        int multiplier = 1;

        if (num == 0) {
            mappedValue = mapping[0];
        } else {
            while (num > 0) {
                int digit = num % 10;
                mappedValue = mapping[digit] * multiplier + mappedValue;
                multiplier *= 10;
                num /= 10;
            }
        }

        mapped[i][0] = mappedValue;
        mapped[i][1] = i;
    }

    // Sort based on mapped value, then original index
    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = 0; j < numsSize - i - 1; j++) {
            if (mapped[j][0] > mapped[j+1][0] || 
                (mapped[j][0] == mapped[j+1][0] && mapped[j][1] > mapped[j+1][1])) {
                // Swap both elements
                int temp0 = mapped[j][0];
                int temp1 = mapped[j][1];
                mapped[j][0] = mapped[j+1][0];
                mapped[j][1] = mapped[j+1][1];
                mapped[j+1][0] = temp0;
                mapped[j+1][1] = temp1;
            }
        }
    }

    // Build result array
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[mapped[i][1]];
    }

    // Free allocated memory
    for (int i = 0; i < numsSize; i++) {
        free(mapped[i]);
    }
    free(mapped);

    return result;
}