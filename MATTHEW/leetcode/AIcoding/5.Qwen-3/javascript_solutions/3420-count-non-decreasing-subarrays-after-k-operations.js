function countNonDecreasingSubarrays(nums, k) {
    const n = nums.length;
    let result = 0;
    let left = 0;
    let changes = 0;

    for (let right = 0; right < n; right++) {
        if (right > 0 && nums[right] < nums[right - 1]) {
            changes++;
        }

        while (changes > k) {
            if (nums[left + 1] < nums[left]) {
                changes--;
            }
            left++;
        }

        result += right - left + 1;
    }

    return result;
}