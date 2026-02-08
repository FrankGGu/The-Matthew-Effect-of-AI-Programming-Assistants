function longestSubarray(nums, k) {
    let left = 0;
    const count = new Map();
    let maxLength = 0;

    for (let right = 0; right < nums.length; right++) {
        count.set(nums[right], (count.get(nums[right]) || 0) + 1);

        while (count.size > k) {
            count.set(nums[left], count.get(nums[left]) - 1);
            if (count.get(nums[left]) === 0) {
                count.delete(nums[left]);
            }
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
}