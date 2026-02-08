int minimumOperations(int* nums, int numsSize) {
    int count[100001] = {0};
    int maxFreq = 0, secondMaxFreq = 0, maxNum = 0, secondMaxNum = 0;

    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
        if (count[nums[i]] > maxFreq) {
            secondMaxFreq = maxFreq;
            secondMaxNum = maxNum;
            maxFreq = count[nums[i]];
            maxNum = nums[i];
        } else if (count[nums[i]] > secondMaxFreq && nums[i] != maxNum) {
            secondMaxFreq = count[nums[i]];
            secondMaxNum = nums[i];
        }
    }

    if (maxFreq + secondMaxFreq <= (numsSize + 1) / 2) {
        return 0;
    }

    int operations = numsSize - maxFreq;
    if (maxNum != secondMaxNum) {
        operations = numsSize - maxFreq - secondMaxFreq;
    }

    return operations;
}