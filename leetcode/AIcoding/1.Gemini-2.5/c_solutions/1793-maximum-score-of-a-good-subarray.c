int maxScore(int* nums, int numsSize, int k) {
    int left = k;
    int right = k;
    int min_val = nums[k];
    long long max_score = (long long)nums[k];

    while (left > 0 || right < numsSize - 1) {
        if (left > 0 && right < numsSize - 1) {
            if (nums[left - 1] > nums[right + 1]) {
                left--;
                min_val = (min_val < nums[left]) ? min_val : nums[left];
            } else {
                right++;
                min_val = (min_val < nums[right]) ? min_val : nums[right];
            }
        } else if (left > 0) {
            left--;
            min_val = (min_val < nums[left]) ? min_val : nums[left];
        } else { // right < numsSize - 1
            right++;
            min_val = (min_val < nums[right]) ? min_val : nums[right];
        }

        long long current_score = (long long)min_val * (right - left + 1);
        max_score = (max_score > current_score) ? max_score : current_score;
    }

    return (int)max_score;
}