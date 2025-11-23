function countSubarrays(nums, k) {
    let n = nums.length;
    let total = 0;
    let left = 0;
    let sum = 0;

    for (let right = 0; right < n; right++) {
        sum += nums[right];

        while (sum * (right - left + 1) >= k) {
            sum -= nums[left];
            left++;
        }

        total += right - left + 1;
    }

    return total;
}