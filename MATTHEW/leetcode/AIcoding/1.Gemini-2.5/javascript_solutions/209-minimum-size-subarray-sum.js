var minSubArrayLen = function(target, nums) {
    let minLen = Infinity;
    let currentSum = 0;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        currentSum += nums[right];

        while (currentSum >= target) {
            minLen = Math.min(minLen, right - left + 1);
            currentSum -= nums[left];
            left++;
        }
    }

    return minLen === Infinity ? 0 : minLen;
};