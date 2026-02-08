var minOperations = function(nums) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let left = 0, result = Infinity;

    for (let right = 0; right < n; right++) {
        while (nums[right] - nums[left] > n - 1) {
            left++;
        }
        result = Math.min(result, n - (right - left + 1));
    }

    return result;
};