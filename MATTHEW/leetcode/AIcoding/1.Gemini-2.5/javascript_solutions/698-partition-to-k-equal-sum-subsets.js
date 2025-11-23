var canPartitionKSubsets = function(nums, k) {
    let totalSum = 0;
    for (let num of nums) {
        totalSum += num;
    }

    if (totalSum % k !== 0) {
        return false;
    }

    const targetSum = totalSum / k;
    const n = nums.length;
    const visited = new Array(n).fill(false);

    nums.sort((a, b) => b - a);

    if (nums[0] > targetSum) {
        return false;
    }

    function backtrack(currentSubsetIndex, currentSum, startIndex) {
        if (currentSubsetIndex === k) {
            return true;
        }

        if (currentSum === targetSum) {
            return backtrack(currentSubsetIndex + 1, 0, 0);
        }

        for (let i = startIndex; i < n; i++) {
            if (!visited[i] && currentSum + nums[i] <= targetSum) {
                visited[i] = true;
                if (backtrack(currentSubsetIndex, currentSum + nums[i], i + 1)) {
                    return true;
                }
                visited[i] = false;
            }
        }

        return false;
    }

    return backtrack(0, 0, 0);
};