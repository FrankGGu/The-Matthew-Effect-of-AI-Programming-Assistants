long long countSubarrays(int* nums, int numsSize, int minK, int maxK) {
    long long count = 0;
    int bad_idx = -1;
    int min_idx = -1;
    int max_idx = -1;

    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] < minK || nums[i] > maxK) {
            bad_idx = i;
        }
        if (nums[i] == minK) {
            min_idx = i;
        }
        if (nums[i] == maxK) {
            max_idx = i;
        }

        int left_bound = bad_idx + 1;
        int right_bound = (min_idx < max_idx) ? min_idx : max_idx;

        if (right_bound >= left_bound) {
            count += (long long)(right_bound - left_bound + 1);
        }
    }

    return count;
}