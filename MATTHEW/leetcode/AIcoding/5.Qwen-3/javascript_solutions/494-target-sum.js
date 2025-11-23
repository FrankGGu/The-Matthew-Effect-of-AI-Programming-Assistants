function findTargetSumWays(nums, S) {
    const memo = {};

    function dfs(index, sum) {
        if (index === nums.length) {
            return sum === S ? 1 : 0;
        }

        const key = `${index},${sum}`;
        if (memo.hasOwnProperty(key)) {
            return memo[key];
        }

        const add = dfs(index + 1, sum + nums[index]);
        const subtract = dfs(index + 1, sum - nums[index]);

        memo[key] = add + subtract;
        return memo[key];
    }

    return dfs(0, 0);
}