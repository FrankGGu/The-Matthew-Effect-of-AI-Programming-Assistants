var numOfWays = function(nums) {
    const mod = 1000000007;

    const comb = (n, k) => {
        if (k > n) return 0;
        let res = 1;
        for (let i = 0; i < k; i++) {
            res = (res * (n - i)) % mod;
            res = (res * modInverse(i + 1, mod)) % mod;
        }
        return res;
    };

    const modInverse = (a, p) => {
        let m0 = p, y = 0, x = 1;
        if (p === 1) return 0;
        while (a > 1) {
            let q = Math.floor(a / p);
            let t = p;
            p = a % p, a = t;
            t = y;
            y = x - q * y;
            x = t;
        }
        if (x < 0) x += m0;
        return x;
    };

    const countWays = (nums) => {
        if (nums.length <= 2) return 1;
        const root = nums[0];
        const left = nums.filter(x => x < root);
        const right = nums.filter(x => x > root);
        return (comb(left.length + right.length, left.length) * countWays(left) % mod * countWays(right) % mod) % mod;
    };

    return (countWays(nums) - 1 + mod) % mod;
};