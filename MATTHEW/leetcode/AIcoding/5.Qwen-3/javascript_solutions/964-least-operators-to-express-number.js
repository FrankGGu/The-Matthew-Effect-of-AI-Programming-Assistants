function leastOperators(target, nums) {
    const memo = {};

    function dfs(n) {
        if (n === 0) return 0;
        if (n === 1) return 1;
        if (memo[n] !== undefined) return memo[n];

        let res = Infinity;
        let k = 0;
        let curr = 1;

        while (curr < n) {
            curr *= nums;
            k++;
        }

        if (curr === n) {
            res = k;
        } else {
            res = Math.min(res, dfs(curr - n) + k);
            res = Math.min(res, dfs(n - curr / nums) + k - 1);
        }

        memo[n] = res;
        return res;
    }

    return dfs(target);
}