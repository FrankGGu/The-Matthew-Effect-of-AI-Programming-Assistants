int maximumHeight(int* nums, int numsSize) {
    int maxHeight = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                if (nums[i] + nums[j] > nums[k] && nums[i] + nums[k] > nums[j] && nums[j] + nums[k] > nums[i]) {
                    int height = (nums[i] + nums[j] + nums[k]) / 3;
                    if (height > maxHeight) {
                        maxHeight = height;
                    }
                }
            }
        }
    }
    return maxHeight;
}