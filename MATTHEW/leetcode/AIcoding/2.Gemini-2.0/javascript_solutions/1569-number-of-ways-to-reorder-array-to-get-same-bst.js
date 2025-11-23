var numOfWays = function(nums) {
    const MOD = 10**9 + 7;

    function combinations(n, k) {
        if (k < 0 || k > n) return 0;
        if (k === 0 || k === n) return 1;
        if (k > n / 2) k = n - k;

        let res = 1;
        for (let i = 1; i <= k; ++i) {
            res = (res * (n - i + 1)) / i;
        }
        return res;
    }

    function solve(arr) {
        if (arr.length <= 1) return 1;

        const root = arr[0];
        const left = [];
        const right = [];

        for (let i = 1; i < arr.length; ++i) {
            if (arr[i] < root) {
                left.push(arr[i]);
            } else {
                right.push(arr[i]);
            }
        }

        const leftWays = solve(left);
        const rightWays = solve(right);
        const comb = combinations(left.length + right.length, left.length);

        return (((comb % MOD) * (leftWays % MOD)) % MOD * (rightWays % MOD)) % MOD;
    }

    return (solve(nums) - 1 + MOD) % MOD;
};