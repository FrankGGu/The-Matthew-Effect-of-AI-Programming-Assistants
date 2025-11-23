long long maximumSubarraySum(int* nums, int numsSize, int k) {
    long long maxSum = LLONG_MIN;
    long long prefixSum = 0;

    typedef struct {
        int key;
        long long value;
    } MapEntry;

    MapEntry *map = (MapEntry*)malloc(numsSize * sizeof(MapEntry));
    int mapSize = 0;

    for (int i = 0; i < numsSize; i++) {
        prefixSum += nums[i];

        for (int j = 0; j < mapSize; j++) {
            if (abs(nums[i] - map[j].key) == k) {
                long long sum = prefixSum - map[j].value;
                if (sum > maxSum) {
                    maxSum = sum;
                }
            }
        }

        int found = 0;
        for (int j = 0; j < mapSize; j++) {
            if (map[j].key == nums[i]) {
                if (map[j].value > prefixSum - nums[i]) {
                    map[j].value = prefixSum - nums[i];
                }
                found = 1;
                break;
            }
        }

        if (!found) {
            map[mapSize].key = nums[i];
            map[mapSize].value = prefixSum - nums[i];
            mapSize++;
        }

        if (nums[i] > maxSum) {
            maxSum = nums[i];
        }
    }

    free(map);
    return maxSum > LLONG_MIN ? maxSum : 0;
}