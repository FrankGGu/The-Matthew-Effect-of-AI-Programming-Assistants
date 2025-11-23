var maxConsecutiveElements = function(nums, k) {
    nums.sort((a, b) => a - b);
    let left = 0;
    let maxLen = 0;
    let cost = 0;

    for (let right = 0; right < nums.length; right++) {
        cost += (nums[right] - (nums[left] + (right - left)));

        while (cost > k) {
            cost -= (nums[right] - (nums[left] + (right - left)));
            cost -= (nums[left + (right - left)] - nums[left]);
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};