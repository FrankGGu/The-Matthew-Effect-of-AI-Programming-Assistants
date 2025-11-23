int numIdenticalPairs(int* nums, int numsSize) {
    int count[101] = {0};
    int goodPairs = 0;

    for (int i = 0; i < numsSize; i++) {
        goodPairs += count[nums[i]]++;
    }

    return goodPairs;
}