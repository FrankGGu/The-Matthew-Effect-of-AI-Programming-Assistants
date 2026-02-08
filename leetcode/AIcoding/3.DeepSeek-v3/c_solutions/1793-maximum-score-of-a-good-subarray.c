int maximumScore(int* nums, int numsSize, int k) {
    int left = k, right = k;
    int min_val = nums[k];
    int max_score = nums[k];

    while (left > 0 || right < numsSize - 1) {
        if (left == 0) {
            right++;
        } else if (right == numsSize - 1) {
            left--;
        } else if (nums[left - 1] > nums[right + 1]) {
            left--;
        } else {
            right++;
        }
        min_val = nums[left] < min_val ? nums[left] : min_val;
        min_val = nums[right] < min_val ? nums[right] : min_val;
        int score = min_val * (right - left + 1);
        max_score = score > max_score ? score : max_score;
    }

    return max_score;
}