var shortestSuperstring = function(A) {
    const n = A.length;
    const overlap = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            let len = Math.min(A[i].length, A[j].length);
            for (let k = len; k > 0; k--) {
                if (A[i].substring(A[i].length - k) === A[j].substring(0, k)) {
                    overlap[i][j] = k;
                    break;
                }
            }
        }
    }

    let dp = Array(1 << n).fill(null).map(() => Array(n).fill(""));
    let path = Array(1 << n).fill(null).map(() => Array(n).fill(0));

    for (let mask = 1; mask < (1 << n); mask++) {
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) > 0) {
                let prevMask = mask ^ (1 << i);
                if (prevMask === 0) {
                    dp[mask][i] = A[i];
                } else {
                    for (let j = 0; j < n; j++) {
                        if ((prevMask & (1 << j)) > 0) {
                            let current = dp[prevMask][j] + A[i].substring(overlap[j][i]);
                            if (dp[mask][i] === "" || current.length < dp[mask][i].length) {
                                dp[mask][i] = current;
                                path[mask][i] = j;
                            }
                        }
                    }
                }
            }
        }
    }

    let mask = (1 << n) - 1;
    let minLen = Infinity;
    let last = -1;
    for (let i = 0; i < n; i++) {
        if (dp[mask][i].length < minLen) {
            minLen = dp[mask][i].length;
            last = i;
        }
    }

    let result = dp[mask][last];

    return result;
};