int countBadPairs(int* nums, int numsSize) {
    long long total = (long long)numsSize * (numsSize - 1) / 2;
    int count[200001] = {0};

    for (int i = 0; i < numsSize; i++) {
        int diff = nums[i] - i;
        total -= count[diff + 100000];
        count[diff + 100000]++;
    }

    return total;
}