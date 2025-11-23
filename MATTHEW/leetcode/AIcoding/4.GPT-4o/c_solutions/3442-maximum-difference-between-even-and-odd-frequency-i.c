int findMaximumDifference(int* nums, int numsSize) {
    int freq[101] = {0};
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }
    int maxEven = 0, maxOdd = 0;
    for (int i = 0; i < 101; i++) {
        if (freq[i] % 2 == 0) {
            if (freq[i] > maxEven) {
                maxEven = freq[i];
            }
        } else {
            if (freq[i] > maxOdd) {
                maxOdd = freq[i];
            }
        }
    }
    return maxEven - maxOdd;
}