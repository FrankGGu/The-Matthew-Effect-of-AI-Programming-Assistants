var countSubarrays = function(nums, k) {
    let left = 0;
    let sum = 0;
    let res = 0;
    for (let right = 0; right < nums.length; right++) {
        sum += nums[right];
        while (sum * (right - left + 1) >= k) {
            sum -= nums[left];
            left++;
        }
        res += right - left + 1;
    }
    return res;
};