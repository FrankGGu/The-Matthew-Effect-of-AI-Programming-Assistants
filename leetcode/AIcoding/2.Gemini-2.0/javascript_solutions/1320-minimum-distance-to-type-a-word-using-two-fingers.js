var minimumDistance = function(word) {
    const n = word.length;
    const dp = Array(n + 1).fill(null).map(() => Array(27).fill(null).map(() => Array(27).fill(Infinity)));

    dp[0][26][26] = 0;

    for (let i = 0; i < n; i++) {
        const charCode = word.charCodeAt(i) - 'A'.charCodeAt(0);

        for (let left = 0; left < 27; left++) {
            for (let right = 0; right < 27; right++) {
                if (dp[i][left][right] === Infinity) continue;

                const leftDist = (left === 26) ? 0 : Math.abs(Math.floor(left / 6) - Math.floor(charCode / 6)) + Math.abs((left % 6) - (charCode % 6));
                const rightDist = (right === 26) ? 0 : Math.abs(Math.floor(right / 6) - Math.floor(charCode / 6)) + Math.abs((right % 6) - (charCode % 6));

                dp[i + 1][charCode][right] = Math.min(dp[i + 1][charCode][right], dp[i][left][right] + leftDist);
                dp[i + 1][left][charCode] = Math.min(dp[i + 1][left][charCode], dp[i][left][right] + rightDist);
            }
        }
    }

    let minDistance = Infinity;
    for (let left = 0; left < 27; left++) {
        for (let right = 0; right < 27; right++) {
            minDistance = Math.min(minDistance, dp[n][left][right]);
        }
    }

    return minDistance;
};