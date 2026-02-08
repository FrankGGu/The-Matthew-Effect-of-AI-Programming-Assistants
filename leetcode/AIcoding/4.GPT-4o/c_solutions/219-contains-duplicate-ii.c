int containsNearbyDuplicate(int* nums, int numsSize, int k) {
    if (numsSize < 2 || k < 1) return 0;
    int map[100000] = {0};
    for (int i = 0; i < numsSize; i++) {
        if (map[nums[i] + 10000] > 0 && i - map[nums[i] + 10000] <= k) {
            return 1;
        }
        map[nums[i] + 10000] = i + 1;
    }
    return 0;
}