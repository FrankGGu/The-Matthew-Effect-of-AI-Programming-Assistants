typedef long long ll;

int findMinIndex(int* nums, int numsSize) {
    int minIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[minIndex]) {
            minIndex = i;
        }
    }
    return minIndex;
}

int* getFinalState(int* nums, int numsSize, int k, int multiplier, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
    }

    for (int i = 0; i < k; i++) {
        int minIndex = findMinIndex(result, numsSize);
        result[minIndex] *= multiplier;
    }

    return result;
}