var minIncrements = function(n, cost) {
    let res = 0;

    const dfs = (node) => {
        if (node >= n) return 0;
        const left = dfs(2 * node + 1);
        const right = dfs(2 * node + 2);
        res += Math.abs(left - right);
        return cost[node] + Math.max(left, right);
    };

    dfs(0);
    return res;
};