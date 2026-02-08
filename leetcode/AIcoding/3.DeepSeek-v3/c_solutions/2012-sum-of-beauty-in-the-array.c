int sumOfBeauties(int* nums, int numsSize) {
    int* leftMax = (int*)malloc(numsSize * sizeof(int));
    int* rightMin = (int*)malloc(numsSize * sizeof(int));

    leftMax[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        leftMax[i] = (nums[i] > leftMax[i-1]) ? nums[i] : leftMax[i-1];
    }

    rightMin[numsSize-1] = nums[numsSize-1];
    for (int i = numsSize-2; i >= 0; i--) {
        rightMin[i] = (nums[i] < rightMin[i+1]) ? nums[i] : rightMin[i+1];
    }

    int beauty = 0;
    for (int i = 1; i < numsSize-1; i++) {
        if (leftMax[i-1] < nums[i] && nums[i] < rightMin[i+1]) {
            beauty += 2;
        } else if (nums[i-1] < nums[i] && nums[i] < nums[i+1]) {
            beauty += 1;
        }
    }

    free(leftMax);
    free(rightMin);
    return beauty;
}