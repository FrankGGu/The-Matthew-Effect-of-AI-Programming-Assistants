function minSubarrayLen(s, nums) {
    let n = nums.length;
    let left = 0;
    let currentSum = 0;
    let minLength = Infinity;

    for (let right = 0; right < n; right++) {
        currentSum += nums[right];

        while (currentSum >= s) {
            minLength = Math.min(minLength, right - left + 1);
            currentSum -= nums[left];
            left++;
        }
    }

    return minLength === Infinity ? 0 : minLength;
}