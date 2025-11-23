int numIdenticalPairs(int* nums, int numsSize) {
    int count = 0;
    int freq[101] = {0};

    for (int i = 0; i < numsSize; i++) {
        count += freq[nums[i]]++;
    }

    return count;
}