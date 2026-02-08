var minimumDistance = function(word) {
    const n = word.length;
    const dp = new Array(n + 1).fill().map(() => 
        new Array(26).fill().map(() => new Array(26).fill(Infinity))
    );

    for (let i = 0; i < 26; i++) {
        for (let j = 0; j < 26; j++) {
            dp[0][i][j] = 0;
        }
    }

    const getDistance = (a, b) => {
        const x1 = Math.floor((a.charCodeAt(0) - 'A'.charCodeAt(0)) / 6);
        const y1 = (a.charCodeAt(0) - 'A'.charCodeAt(0)) % 6;
        const x2 = Math.floor((b.charCodeAt(0) - 'A'.charCodeAt(0)) / 6);
        const y2 = (b.charCodeAt(0) - 'A'.charCodeAt(0)) % 6;
        return Math.abs(x1 - x2) + Math.abs(y1 - y2);
    };

    for (let k = 1; k <= n; k++) {
        const c = word[k - 1];
        const pos = c.charCodeAt(0) - 'A'.charCodeAt(0);
        for (let i = 0; i < 26; i++) {
            for (let j = 0; j < 26; j++) {
                if (dp[k - 1][i][j] !== Infinity) {
                    dp[k][pos][j] = Math.min(dp[k][pos][j], dp[k - 1][i][j] + getDistance(String.fromCharCode(i + 'A'.charCodeAt(0)), c));
                    dp[k][i][pos] = Math.min(dp[k][i][pos], dp[k - 1][i][j] + getDistance(String.fromCharCode(j + 'A'.charCodeAt(0)), c));
                }
            }
        }
    }

    let minDist = Infinity;
    for (let i = 0; i < 26; i++) {
        for (let j = 0; j < 26; j++) {
            minDist = Math.min(minDist, dp[n][i][j]);
        }
    }
    return minDist;
};