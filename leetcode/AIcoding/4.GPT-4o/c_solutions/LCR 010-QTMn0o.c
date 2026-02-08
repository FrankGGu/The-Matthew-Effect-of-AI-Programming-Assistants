int subarraySum(int* nums, int numsSize, int k) {
    int count = 0;
    int sum = 0;
    int* hashmap = (int*)calloc(20001, sizeof(int));
    hashmap[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (sum >= k) {
            count += hashmap[sum - k + 10000];
        }
        hashmap[sum + 10000]++;
    }

    free(hashmap);
    return count;
}