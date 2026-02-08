var minimumDistance = function(word) {
    const n = word.length;
    const dp = Array.from({ length: 26 }, () => Array(26).fill(Infinity));
    for (let i = 0; i < 26; i++) {
        dp[i][i] = 0;
    }

    for (let i = 0; i < n; i++) {
        const c = word.charCodeAt(i) - 'a'.charCodeAt(0);
        const nextDp = Array.from({ length: 26 }, () => Array(26).fill(Infinity));
        for (let a = 0; a < 26; a++) {
            for (let b = 0; b < 26; b++) {
                if (dp[a][b] === Infinity) continue;
                // Move finger from a to c
                nextDp[c][b] = Math.min(nextDp[c][b], dp[a][b] + distance(a, c));
                // Move finger from b to c
                nextDp[a][c] = Math.min(nextDp[a][c], dp[a][b] + distance(b, c));
            }
        }
        dp.splice(0, 26, ...nextDp);
    }

    let min = Infinity;
    for (let a = 0; a < 26; a++) {
        for (let b = 0; b < 26; b++) {
            min = Math.min(min, dp[a][b]);
        }
    }
    return min;
};

function distance(a, b) {
    return Math.hypot((a % 6) - (b % 6), Math.floor(a / 6) - Math.floor(b / 6));
}