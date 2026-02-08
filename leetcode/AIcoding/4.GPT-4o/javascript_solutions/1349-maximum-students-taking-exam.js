var maxStudents = function(seats) {
    const m = seats.length, n = seats[0].length;
    const dp = Array(1 << n).fill(0);

    for (let i = 0; i < m; i++) {
        const newDp = Array(1 << n).fill(0);
        for (let mask = 0; mask < (1 << n); mask++) {
            if (dp[mask] === 0 && mask !== 0) continue;
            for (let newMask = 0; newMask < (1 << n); newMask++) {
                if ((newMask & mask) === 0 && (newMask & (newMask >> 1)) === 0 && (newMask & (newMask << 1)) === 0) {
                    let valid = true;
                    for (let j = 0; j < n; j++) {
                        if ((newMask & (1 << j)) !== 0 && seats[i][j] === '#') {
                            valid = false;
                            break;
                        }
                    }
                    if (valid) {
                        newDp[newMask] = Math.max(newDp[newMask], dp[mask] + [...newMask.toString(2)].reverse().join('').match(/1/g)?.length || 0);
                    }
                }
            }
        }
        dp = newDp;
    }
    return Math.max(...dp);
};