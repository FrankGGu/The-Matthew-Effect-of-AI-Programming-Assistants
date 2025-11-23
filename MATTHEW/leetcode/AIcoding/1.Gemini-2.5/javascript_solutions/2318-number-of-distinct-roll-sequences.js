const gcd = (a, b) => {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
};

const coprime = Array(7).fill(0).map(() => Array(7).fill(false));
for (let i = 1; i <= 6; i++) {
    for (let j = 1; j <= 6; j++) {
        coprime[i][j] = (gcd(i, j) === 1);
    }
}

const MOD = 10 ** 9 + 7;

var distinctSequences = function(n) {
    if (n === 1) {
        return 6;
    }

    let dp = Array(6).fill(0).map(() => Array(6).fill(0));

    for (let prev = 0; prev < 6; prev++) {
        for (let last = 0; last < 6; last++) {
            if (coprime[prev + 1][last + 1]) {
                dp[last][prev] = 1;
            }
        }
    }

    for (let k = 3; k <= n; k++) {
        let new_dp = Array(6).fill(0).map(() => Array(6).fill(0));
        for (let last = 0; last < 6; last++) {
            for (let prev = 0; prev < 6; prev++) {
                if (dp[last][prev] > 0) {
                    for (let newLast = 0; newLast < 6; newLast++) {
                        if (coprime[last + 1][newLast + 1] && newLast !== prev) {
                            new_dp[newLast][last] = (new_dp[newLast][last] + dp[last][prev]) % MOD;
                        }
                    }
                }
            }
        }
        dp = new_dp;
    }

    let total_ans = 0;
    for (let last = 0; last < 6; last++) {
        for (let prev = 0; prev < 6; prev++) {
            total_ans = (total_ans + dp[last][prev]) % MOD;
        }
    }

    return total_ans;
};