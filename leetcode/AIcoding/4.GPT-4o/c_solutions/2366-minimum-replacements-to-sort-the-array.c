int minimumReplacement(int* nums, int numsSize) {
    long long replacements = 0;
    int prev = nums[numsSize - 1];

    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] > prev) {
            long long count = (nums[i] + prev - 1) / prev;
            replacements += count - 1;
            prev = nums[i] / count;
        } else {
            prev = nums[i];
        }
    }

    return (int)replacements;
}