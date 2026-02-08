var minimumSubarrayLength = function(nums, k) {
    let minLen = Infinity;
    let currentOR = 0;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        currentOR |= nums[right];

        while (left <= right && currentOR >= k) {
            minLen = Math.min(minLen, right - left + 1);
            currentOR &= ~nums[left];
            left++;
        }
    }

    return minLen === Infinity ? -1 : minLen;
};