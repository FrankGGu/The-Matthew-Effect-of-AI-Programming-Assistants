long long minimumReplacement(int* nums, int numsSize) {
    long long replacements = 0;
    long long prev_num = nums[numsSize - 1];

    for (int i = numsSize - 2; i >= 0; i--) {
        long long current_num = nums[i];

        if (current_num <= prev_num) {
            prev_num = current_num;
        } else {
            long long k = (current_num + prev_num - 1) / prev_num;
            replacements += (k - 1);
            prev_num = current_num / k;
        }
    }

    return replacements;
}