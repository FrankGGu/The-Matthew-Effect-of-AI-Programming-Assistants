var minOperations = function(nums, k) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const mid = Math.floor(n / 2);
    let operations = 0;

    for (let i = mid; i < n; i++) {
        if (nums[i] < k) {
            operations += k - nums[i];
        } else {
            break;
        }
    }

    return operations;
};