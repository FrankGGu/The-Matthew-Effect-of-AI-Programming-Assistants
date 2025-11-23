int minPairRemovals(int* nums, int numsSize) {
    int count[100001] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
    }

    int pairs = 0;
    for (int i = 0; i < 100001; i++) {
        pairs += count[i] / 2;
    }

    return numsSize - 2 * pairs;
}