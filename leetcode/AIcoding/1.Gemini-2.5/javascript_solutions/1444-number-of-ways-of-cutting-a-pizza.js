var ways = function(pizza, k) {
    const R = pizza.length;
    const C = pizza[0].length;
    const MOD = 1000000007;

    const prefixSum = Array(R + 1).fill(0).map(() => Array(C + 1).fill(0));

    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            prefixSum[r + 1][c + 1] = prefixSum[r][c + 1] + prefixSum[r + 1][c] - prefixSum[r][c] + (pizza[r][c] === 'A' ? 1 : 0);
        }
    }

    const countApples = (r1, c1, r2, c2) => {
        return prefixSum[r2 + 1][c2 + 1] - prefixSum[r1][c2 + 1] - prefixSum[r2 + 1][c1] + prefixSum[r1][c1];
    };

    const dp = Array(k).fill(0).map(() => Array(R).fill(0).map(() => Array(C).fill(0)));

    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            if (countApples(r, c, R - 1, C - 1) > 0) {
                dp[0][r][c] = 1;
            }
        }
    }

    for (let k_rem = 1; k_rem < k; k_rem++) {
        for (let r = 0; r < R; r++) {
            for (let c = 0; c < C; c++) {
                let currentWays = 0;

                for (let nr = r; nr < R - 1; nr++) {
                    if (countApples(r, c, nr, C - 1) > 0) {
                        currentWays = (currentWays + dp[k_rem - 1][nr + 1][c]) % MOD;
                    }
                }

                for (let nc = c; nc < C - 1; nc++) {
                    if (countApples(r, c, R - 1, nc) > 0) {
                        currentWays = (currentWays + dp[k_rem - 1][r][nc + 1]) % MOD;
                    }
                }
                dp[k_rem][r][c] = currentWays;
            }
        }
    }

    return dp[k - 1][0][0];
};