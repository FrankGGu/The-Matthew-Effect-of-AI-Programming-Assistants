int subarraySum(int* nums, int numsSize, int k) {
    int count = 0;
    int sum = 0;
    int* map = (int*)calloc(20001, sizeof(int));
    map[10000] = 1;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (sum - k >= -10000 && sum - k <= 10000) {
            count += map[sum - k + 10000];
        }
        if (sum >= -10000 && sum <= 10000) {
            map[sum + 10000]++;
        }
    }

    free(map);
    return count;
}