var maxStudents = function(seats) {
    const m = seats.length;
    const n = seats[0].length;
    const dp = new Array(m + 1).fill(0).map(() => new Array(1 << n).fill(-1));
    dp[0][0] = 0;

    for (let i = 1; i <= m; i++) {
        for (let mask = 0; mask < (1 << n); mask++) {
            if (dp[i - 1][mask] === -1) continue;
            for (let newMask = 0; newMask < (1 << n); newMask++) {
                if (isValid(seats, i - 1, newMask) && isCompatible(mask, newMask, n)) {
                    const count = countBits(newMask);
                    if (dp[i][newMask] < dp[i - 1][mask] + count) {
                        dp[i][newMask] = dp[i - 1][mask] + count;
                    }
                }
            }
        }
    }

    return Math.max(...dp[m]);
};

function isValid(seats, row, mask) {
    const n = seats[0].length;
    for (let j = 0; j < n; j++) {
        if ((mask & (1 << j)) && seats[row][j] === '#') {
            return false;
        }
        if (j > 0 && (mask & (1 << j)) && (mask & (1 << (j - 1)))) {
            return false;
        }
    }
    return true;
}

function isCompatible(prevMask, currMask, n) {
    for (let j = 0; j < n; j++) {
        if ((currMask & (1 << j))) {
            if (j > 0 && (prevMask & (1 << (j - 1)))) return false;
            if (j < n - 1 && (prevMask & (1 << (j + 1)))) return false;
        }
    }
    return true;
}

function countBits(mask) {
    let count = 0;
    while (mask) {
        count += mask & 1;
        mask >>= 1;
    }
    return count;
}