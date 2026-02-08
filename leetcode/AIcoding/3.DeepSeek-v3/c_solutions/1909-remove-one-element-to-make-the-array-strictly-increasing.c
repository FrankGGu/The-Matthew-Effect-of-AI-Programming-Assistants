bool canBeIncreasing(int* nums, int numsSize) {
    int count = 0;
    int index = -1;

    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] >= nums[i + 1]) {
            count++;
            index = i;
        }
    }

    if (count == 0) {
        return true;
    }

    if (count > 1) {
        return false;
    }

    if (index == 0 || index == numsSize - 2) {
        return true;
    }

    if (nums[index - 1] < nums[index + 1] || nums[index] < nums[index + 2]) {
        return true;
    }

    return false;
}