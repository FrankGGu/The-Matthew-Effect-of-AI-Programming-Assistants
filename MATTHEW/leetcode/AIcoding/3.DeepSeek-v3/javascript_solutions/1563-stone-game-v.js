var stoneGameV = function(stoneValue) {
    const n = stoneValue.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stoneValue[i];
    }

    const memo = new Array(n).fill().map(() => new Array(n).fill(-1));

    const dfs = (left, right) => {
        if (left === right) return 0;
        if (memo[left][right] !== -1) return memo[left][right];

        let res = 0;
        for (let i = left; i < right; i++) {
            const leftSum = prefixSum[i + 1] - prefixSum[left];
            const rightSum = prefixSum[right + 1] - prefixSum[i + 1];

            if (leftSum < rightSum) {
                res = Math.max(res, leftSum + dfs(left, i));
            } else if (leftSum > rightSum) {
                res = Math.max(res, rightSum + dfs(i + 1, right));
            } else {
                res = Math.max(res, leftSum + Math.max(dfs(left, i), dfs(i + 1, right)));
            }
        }

        memo[left][right] = res;
        return res;
    };

    return dfs(0, n - 1);
};