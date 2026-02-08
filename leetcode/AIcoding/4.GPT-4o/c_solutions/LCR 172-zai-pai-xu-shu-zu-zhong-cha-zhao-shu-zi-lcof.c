int numIdenticalPairs(int* nums, int numsSize) {
    int count = 0;
    int freq[101] = {0};

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    for (int i = 0; i < 101; i++) {
        count += freq[i] * (freq[i] - 1) / 2;
    }

    return count;
}