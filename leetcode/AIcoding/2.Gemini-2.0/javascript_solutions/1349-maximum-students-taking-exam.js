var maxStudents = function(seats) {
    const m = seats.length;
    const n = seats[0].length;
    const dp = new Array(m + 1).fill(null).map(() => new Array(1 << n).fill(-1));

    dp[0][0] = 0;

    for (let i = 1; i <= m; i++) {
        for (let mask = 0; mask < (1 << n); mask++) {
            let valid = true;
            let count = 0;

            for (let j = 0; j < n; j++) {
                if ((mask >> j) & 1) {
                    count++;
                    if (seats[i - 1][j] === '#') {
                        valid = false;
                        break;
                    }
                    if (j > 0 && ((mask >> (j - 1)) & 1)) {
                        valid = false;
                        break;
                    }
                }
            }

            if (!valid) continue;

            for (let prevMask = 0; prevMask < (1 << n); prevMask++) {
                if (dp[i - 1][prevMask] === -1) continue;

                let conflict = false;
                for (let j = 0; j < n; j++) {
                    if ((mask >> j) & 1) {
                        if (j > 0 && ((prevMask >> (j - 1)) & 1)) {
                            conflict = true;
                            break;
                        }
                        if (j < n - 1 && ((prevMask >> (j + 1)) & 1)) {
                            conflict = true;
                            break;
                        }
                    }
                }

                if (!conflict) {
                    dp[i][mask] = Math.max(dp[i][mask], dp[i - 1][prevMask] + count);
                }
            }
        }
    }

    let ans = 0;
    for (let mask = 0; mask < (1 << n); mask++) {
        ans = Math.max(ans, dp[m][mask]);
    }

    return ans;
};