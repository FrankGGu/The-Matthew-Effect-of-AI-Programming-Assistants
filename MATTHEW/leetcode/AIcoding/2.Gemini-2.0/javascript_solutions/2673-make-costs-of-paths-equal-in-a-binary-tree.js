var minIncrements = function(n, cost) {
    let ans = 0;

    function dfs(i) {
        if (i >= n) {
            return 0;
        }

        let left = dfs(2 * i + 1);
        let right = dfs(2 * i + 2);

        ans += Math.abs(left - right);
        return cost[i] + Math.max(left, right);
    }

    dfs(0);
    return ans;
};