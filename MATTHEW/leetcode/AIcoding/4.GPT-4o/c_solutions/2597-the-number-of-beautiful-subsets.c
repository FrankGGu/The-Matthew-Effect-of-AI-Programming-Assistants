int beautifulSubsets(int* nums, int numsSize, int k) {
    int count = 0;
    int totalSubsets = 1 << numsSize;

    for (int i = 1; i < totalSubsets; i++) {
        int valid = 1;
        for (int j = 0; j < numsSize; j++) {
            if (i & (1 << j)) {
                for (int l = j + 1; l < numsSize; l++) {
                    if (i & (1 << l) && abs(nums[j] - nums[l]) == k) {
                        valid = 0;
                        break;
                    }
                }
                if (!valid) break;
            }
        }
        if (valid) count++;
    }

    return count;
}