function numOfWays(nums) {
    const MOD = 10**9 + 7;

    function comb(n, k, memo = {}) {
        if (k === 0 || k === n) return 1;
        if (memo[`${n},${k}`] !== undefined) return memo[`${n},${k}`];
        memo[`${n},${k}`] = (comb(n - 1, k - 1, memo) + comb(n - 1, k, memo)) % MOD;
        return memo[`${n},${k}`];
    }

    function dfs(arr) {
        if (arr.length <= 1) return 1;

        const root = arr[0];
        const left = [];
        const right = [];

        for (let i = 1; i < arr.length; i++) {
            if (arr[i] < root) left.push(arr[i]);
            else right.push(arr[i]);
        }

        const l = dfs(left);
        const r = dfs(right);
        const c = comb(left.length + right.length, left.length);
        return (c * l % MOD) * r % MOD;
    }

    return (dfs(nums) - 1 + MOD) % MOD;
}