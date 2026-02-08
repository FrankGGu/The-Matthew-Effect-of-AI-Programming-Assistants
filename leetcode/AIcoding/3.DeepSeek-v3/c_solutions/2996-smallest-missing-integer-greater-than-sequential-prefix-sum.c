int missingInteger(int* nums, int numsSize) {
    int prefixSum = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] == nums[i - 1] + 1) {
            prefixSum += nums[i];
        } else {
            break;
        }
    }

    int maxNum = prefixSum;
    int found;
    do {
        found = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] == maxNum) {
                found = 1;
                maxNum++;
                break;
            }
        }
    } while (found);

    return maxNum;
}