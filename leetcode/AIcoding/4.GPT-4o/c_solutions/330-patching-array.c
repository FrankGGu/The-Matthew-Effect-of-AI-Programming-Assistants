int minPatches(int* nums, int numsSize, int n) {
    long long maxReach = 0;
    int patches = 0, i = 0;

    while (maxReach < n) {
        if (i < numsSize && nums[i] <= maxReach + 1) {
            maxReach += nums[i];
            i++;
        } else {
            patches++;
            maxReach += maxReach + 1;
        }
    }

    return patches;
}