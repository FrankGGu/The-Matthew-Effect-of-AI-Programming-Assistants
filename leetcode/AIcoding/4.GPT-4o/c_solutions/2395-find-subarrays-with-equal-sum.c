int findSubarrays(int* nums, int numsSize) {
    int count = 0;
    int sumMap[200001] = {0};

    for (int i = 0; i < numsSize - 1; i++) {
        int sum = nums[i] + nums[i + 1];
        if (sumMap[sum + 100000] == 1) {
            count = 1;
            break;
        }
        sumMap[sum + 100000] = 1;
    }

    return count;
}