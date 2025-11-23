const knightDialer = function(n) {
    const MOD = 1e9 + 7;
    const moves = {
        0: [4, 6],
        1: [6, 8],
        2: [7, 9],
        3: [4, 8],
        4: [0, 3, 9],
        5: [],
        6: [0, 1, 7],
        7: [2, 6],
        8: [1, 3],
        9: [2, 4]
    };

    let dp = new Array(10).fill(1);

    for (let step = 2; step <= n; step++) {
        let nextDP = new Array(10).fill(0);
        for (let num = 0; num < 10; num++) {
            for (const nextNum of moves[num]) {
                nextDP[num] = (nextDP[num] + dp[nextNum]) % MOD;
            }
        }
        dp = nextDP;
    }

    let total = 0;
    for (let num = 0; num < 10; num++) {
        total = (total + dp[num]) % MOD;
    }

    return total;
};