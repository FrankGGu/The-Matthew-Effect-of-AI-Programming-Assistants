int minSubarray(int* nums, int numsSize, int p) {
    long total = 0;
    for (int i = 0; i < numsSize; i++) {
        total = (total + nums[i]) % p;
    }
    if (total == 0) return 0;

    int minLen = numsSize;
    long target = total;
    long sum = 0;
    int map[100000] = {-1};

    map[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        sum = (sum + nums[i]) % p;
        map[sum] = i + 1; // store index for the first occurrence
        int required = (sum - target + p) % p;
        if (map[required] != -1) {
            minLen = fmin(minLen, i + 1 - map[required]);
        }
    }

    return (minLen == numsSize) ? -1 : minLen;
}