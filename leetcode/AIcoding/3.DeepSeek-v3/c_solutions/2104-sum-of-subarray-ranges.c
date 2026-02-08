long long subArrayRanges(int* nums, int numsSize) {
    long long sum = 0;

    for (int i = 0; i < numsSize; i++) {
        int min_val = nums[i];
        int max_val = nums[i];

        for (int j = i; j < numsSize; j++) {
            if (nums[j] < min_val) min_val = nums[j];
            if (nums[j] > max_val) max_val = nums[j];
            sum += (max_val - min_val);
        }
    }

    return sum;
}