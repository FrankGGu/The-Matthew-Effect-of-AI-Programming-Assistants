const numOfWays = function(nums) {
    const mod = 1e9 + 7;
    const n = nums.length;
    const comb = Array.from({ length: n + 1 }, () => new Array(n + 1).fill(0));
    comb[0][0] = 1;
    for (let i = 1; i <= n; i++) {
        comb[i][0] = 1;
        for (let j = 1; j <= i; j++) {
            comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % mod;
        }
    }

    const dfs = (arr) => {
        const m = arr.length;
        if (m <= 2) return 1;
        const left = [];
        const right = [];
        for (let i = 1; i < m; i++) {
            if (arr[i] < arr[0]) left.push(arr[i]);
            else right.push(arr[i]);
        }
        const leftWays = dfs(left) % mod;
        const rightWays = dfs(right) % mod;
        return (((comb[m - 1][left.length] * leftWays) % mod) * rightWays) % mod;
    };

    return (dfs(nums) - 1 + mod) % mod;
};