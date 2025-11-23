int minPatches(int* nums, int numsSize, int n) {
    long long reachable = 0;
    int added_coins = 0;
    int i = 0;

    while (reachable < n) {
        if (i < numsSize && nums[i] <= reachable + 1) {
            reachable += nums[i];
            i++;
        } else {
            reachable += (reachable + 1);
            added_coins++;
        }
    }

    return added_coins;
}