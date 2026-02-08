var minimizeConcatenatedLength = function(words) {
    const n = words.length;
    const dp = Array(n).fill(null).map(() => Array(26).fill(null).map(() => Array(26).fill(Infinity)));

    const firstChar = words[0].charCodeAt(0) - 'a'.charCodeAt(0);
    const lastChar = words[0].charCodeAt(words[0].length - 1) - 'a'.charCodeAt(0);
    dp[0][firstChar][lastChar] = words[0].length;

    for (let i = 1; i < n; i++) {
        const currentFirst = words[i].charCodeAt(0) - 'a'.charCodeAt(0);
        const currentLast = words[i].charCodeAt(words[i].length - 1) - 'a'.charCodeAt(0);
        const currentLength = words[i].length;

        for (let j = 0; j < 26; j++) {
            for (let k = 0; k < 26; k++) {
                if (dp[i - 1][j][k] !== Infinity) {
                    let overlap = 0;
                    if (k === currentFirst) {
                        overlap = 1;
                    }
                    dp[i][j][currentLast] = Math.min(dp[i][j][currentLast], dp[i - 1][j][k] + currentLength - overlap);

                    overlap = 0;
                    if (currentLast === j) {
                        overlap = 1;
                    }
                    dp[i][currentFirst][k] = Math.min(dp[i][currentFirst][k], dp[i - 1][j][k] + currentLength - overlap);
                }
            }
        }
    }

    let minLength = Infinity;
    for (let i = 0; i < 26; i++) {
        for (let j = 0; j < 26; j++) {
            minLength = Math.min(minLength, dp[n - 1][i][j]);
        }
    }

    return minLength;
};