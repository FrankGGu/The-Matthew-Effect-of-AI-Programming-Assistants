bool containsNearbyDuplicate(int* nums, int numsSize, int k) {
    if (numsSize <= 1 || k <= 0) return false;

    int min = nums[0], max = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min) min = nums[i];
        if (nums[i] > max) max = nums[i];
    }

    int* map = (int*)calloc(max - min + 1, sizeof(int));
    if (!map) return false;

    for (int i = 0; i < numsSize; i++) {
        int idx = nums[i] - min;
        if (map[idx] != 0 && i - (map[idx] - 1) <= k) {
            free(map);
            return true;
        }
        map[idx] = i + 1;
    }

    free(map);
    return false;
}