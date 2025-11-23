var canPartitionKSubsets = function(nums, k) {
    const totalSum = nums.reduce((a, b) => a + b, 0);
    if (totalSum % k !== 0) return false;
    const target = totalSum / k;
    const visited = new Array(nums.length).fill(false);

    const backtrack = (start, currentSum, subsetsLeft) => {
        if (subsetsLeft === 1) return true;
        if (currentSum === target) return backtrack(0, 0, subsetsLeft - 1);
        for (let i = start; i < nums.length; i++) {
            if (!visited[i] && currentSum + nums[i] <= target) {
                visited[i] = true;
                if (backtrack(i + 1, currentSum + nums[i], subsetsLeft)) return true;
                visited[i] = false;
            }
        }
        return false;
    };

    return backtrack(0, 0, k);
};