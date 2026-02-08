var maxOperations = function(nums) {
    const n = nums.length;
    let memo; // Will be a 2D array for memoization

    function dfs(i, j, target) {
        if (i >= j) {
            return 0;
        }
        if (memo[i][j] !== -1) {
            return memo[i][j];
        }

        let res = 0;

        // Option 1: Take nums[i] and nums[i+1]
        // Check if there are at least two elements and their sum matches the target
        if (i + 1 <= j && nums[i] + nums[i+1] === target) {
            res = Math.max(res, 1 + dfs(i+2, j, target));
        }

        // Option 2: Take nums[i] and nums[j]
        // Check if their sum matches the target
        if (nums[i] + nums[j] === target) {
            res = Math.max(res, 1 + dfs(i+1, j-1, target));
        }

        // Option 3: Take nums[j-1] and nums[j]
        // Check if there are at least two elements and their sum matches the target
        if (i <= j - 1 && nums[j-1] + nums[j] === target) {
            res = Math.max(res, 1 + dfs(i, j-2, target));
        }

        memo[i][j] = res;
        return res;
    }

    let max_total_ops = 0;

    // The problem states n >= 2, so these initial operations are always possible.

    // Case 1: Initial operation uses nums[0] and nums[1]
    const target1 = nums[0] + nums[1];
    memo = Array(n).fill(0).map(() => Array(n).fill(-1));
    max_total_ops = Math.max(max_total_ops, 1 + dfs(2, n - 1, target1));

    // Case 2: Initial operation uses nums[0] and nums[n-1]
    const target2 = nums[0] + nums[n-1];
    memo = Array(n).fill(0).map(() => Array(n).fill(-1));
    max_total_ops = Math.max(max_total_ops, 1 + dfs(1, n - 2, target2));

    // Case 3: Initial operation uses nums[n-2] and nums[n-1]
    const target3 = nums[n-2] + nums[n-1];
    memo = Array(n).fill(0).map(() => Array(n).fill(-1));
    max_total_ops = Math.max(max_total_ops, 1 + dfs(0, n - 3, target3));

    return max_total_ops;
};