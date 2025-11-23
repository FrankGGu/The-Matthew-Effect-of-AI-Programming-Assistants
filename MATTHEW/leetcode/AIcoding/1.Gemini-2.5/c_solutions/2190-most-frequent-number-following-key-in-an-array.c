int mostFrequent(int* nums, int numsSize, int key) {
    int counts[1001] = {0}; // Max value for nums[i] is 1000

    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] == key) {
            counts[nums[i+1]]++;
        }
    }

    int maxCount = 0;
    int result = -1;

    for (int i = 0; i <= 1000; i++) {
        if (counts[i] > maxCount) {
            maxCount = counts[i];
            result = i;
        }
    }

    return result;
}