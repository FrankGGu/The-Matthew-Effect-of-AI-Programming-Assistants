var idealArrays = function(n, maxValue) {
    const MOD = 10**9 + 7;

    let dp = Array(maxValue + 1).fill(0);
    let C = Array(n + maxValue).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < n + maxValue; i++) {
        C[i][0] = 1;
    }

    for (let i = 1; i < n + maxValue; i++) {
        for (let j = 1; j < Math.min(i + 1, n); j++) {
            C[i][j] = (C[i - 1][j - 1] + C[i - 1][j]) % MOD;
        }
    }

    let ans = 0;
    for (let i = 1; i <= maxValue; i++) {
        let count = 1;
        let num = i;
        let factors = [];
        for (let j = 2; j * j <= num; j++) {
            if (num % j === 0) {
                let c = 0;
                while (num % j === 0) {
                    num /= j;
                    c++;
                }
                factors.push(c);
            }
        }
        if (num > 1) {
            factors.push(1);
        }

        let k = factors.length;
        if (k === 0) {
            ans = (ans + C[n - 1][0]) % MOD;
        } else {
            let cur = 1;
            for (let j = 0; j < k; j++) {
                cur = (cur * C[n - 2 + factors[j]][factors[j]]) % MOD;
            }
            ans = (ans + cur) % MOD;
        }
    }

    return ans;
};