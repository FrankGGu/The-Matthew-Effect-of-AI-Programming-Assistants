int findPairs(int* nums, int numsSize, int k) {
    if (k < 0) return 0;
    int count = 0;
    int map[20001] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 0) {
            map[-nums[i]]++;
        } else {
            map[nums[i] + 10000]++;
        }
    }

    if (k == 0) {
        for (int i = 0; i < 20001; i++) {
            if (map[i] > 1) count++;
        }
    } else {
        for (int i = 0; i < 20001; i++) {
            if (map[i] > 0 && i + k < 20001 && map[i + k] > 0) {
                count++;
            }
        }
    }

    return count;
}