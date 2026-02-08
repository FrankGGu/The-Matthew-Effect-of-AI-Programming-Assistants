int minimumOperations(int* nums, int numsSize) {
    int freq[101] = {0};
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            freq[nums[i]]++;
        }
    }

    int count = 0;
    for (int i = 1; i <= 100; i++) {
        if (freq[i] > 0) {
            count++;
        }
    }
    return count;
}