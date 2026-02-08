bool checkSubarraySum(int* nums, int numsSize, int k) {
    if (numsSize < 2) return false;
    int* map = (int*)malloc((k + 1) * sizeof(int));
    memset(map, -1, (k + 1) * sizeof(int));
    map[0] = -1;
    int sum = 0;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (k != 0) sum %= k;

        if (map[sum] != -1) {
            if (i - map[sum] > 1) {
                free(map);
                return true;
            }
        } else {
            map[sum] = i;
        }
    }

    free(map);
    return false;
}