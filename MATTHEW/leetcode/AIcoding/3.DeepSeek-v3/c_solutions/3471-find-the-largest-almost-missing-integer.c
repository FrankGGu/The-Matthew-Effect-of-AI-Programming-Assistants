int largestInteger(int* nums, int numsSize, int k) {
    int freq[101] = {0};
    int maxNum = -1;

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    for (int i = 100; i >= 1; i--) {
        if (freq[i] > 0 && freq[i] < k) {
            maxNum = i;
            break;
        }
    }

    return maxNum;
}