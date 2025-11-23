var countSubarrays = function(nums, k) {
    let count = 0;
    let left = 0;
    let currentSum = 0;
    const n = nums.length;

    for (let right = 0; right < n; right++) {
        currentSum += nums[right];

        while (currentSum * (right - left + 1) >= k) {
            currentSum -= nums[left];
            left++;
        }

        if (left <= right) {
            count += (right - left + 1);
        }
    }

    return count;
};