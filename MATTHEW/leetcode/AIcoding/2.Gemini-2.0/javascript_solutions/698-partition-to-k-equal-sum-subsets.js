var canPartitionKSubsets = function(nums, k) {
    const sum = nums.reduce((a, b) => a + b, 0);
    if (sum % k !== 0) return false;
    const target = sum / k;
    const n = nums.length;
    nums.sort((a, b) => b - a);
    const used = new Array(n).fill(false);

    function backtrack(k, currSum, start) {
        if (k === 0) return true;
        if (currSum === target) return backtrack(k - 1, 0, 0);

        for (let i = start; i < n; i++) {
            if (used[i] || currSum + nums[i] > target) continue;
            used[i] = true;
            if (backtrack(k, currSum + nums[i], i + 1)) return true;
            used[i] = false;
        }
        return false;
    }

    return backtrack(k, 0, 0);
};