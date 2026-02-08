var countNonDecreasingSubarrays = function(nums, k) {
    let n = nums.length;
    let ans = 0;
    let left = 0;
    let operations = 0;
    let maxVal = 0;

    for (let right = 0; right < n; right++) {
        maxVal = Math.max(maxVal, nums[right]);
        operations = (right - left + 1) * maxVal;
        let sum = 0;
        for (let i = left; i <= right; i++) {
            sum += nums[i];
        }
        operations -= sum;

        while (operations > k) {
            sum -= nums[left];
            left++;
            maxVal = 0;
            for (let i = left; i <= right; i++) {
                maxVal = Math.max(maxVal, nums[i]);
            }
            operations = (right - left + 1) * maxVal;
            for (let i = left; i <= right; i++) {
                operations -= nums[i];
            }
        }
        ans += (right - left + 1);
    }

    return ans;
};