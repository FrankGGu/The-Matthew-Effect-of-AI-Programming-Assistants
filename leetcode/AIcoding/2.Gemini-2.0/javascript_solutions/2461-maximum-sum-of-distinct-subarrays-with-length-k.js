var maximumSubarraySum = function(nums, k) {
    let max_sum = 0;
    let current_sum = 0;
    let freq = new Map();
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        if (freq.has(nums[right])) {
            freq.set(nums[right], freq.get(nums[right]) + 1);
        } else {
            freq.set(nums[right], 1);
        }
        current_sum += nums[right];

        if (right - left + 1 > k) {
            current_sum -= nums[left];
            freq.set(nums[left], freq.get(nums[left]) - 1);
            if (freq.get(nums[left]) === 0) {
                freq.delete(nums[left]);
            }
            left++;
        }

        if (right - left + 1 === k && freq.size === k) {
            max_sum = Math.max(max_sum, current_sum);
        }
    }

    return max_sum;
};