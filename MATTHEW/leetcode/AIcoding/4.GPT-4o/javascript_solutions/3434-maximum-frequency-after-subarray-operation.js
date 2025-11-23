var maxFrequency = function(nums, k) {
    nums.sort((a, b) => a - b);
    let l = 0, total = 0, maxFreq = 0;

    for (let r = 0; r < nums.length; r++) {
        total += nums[r];

        while (nums[r] * (r - l + 1) - total > k) {
            total -= nums[l];
            l++;
        }

        maxFreq = Math.max(maxFreq, r - l + 1);
    }

    return maxFreq;
};