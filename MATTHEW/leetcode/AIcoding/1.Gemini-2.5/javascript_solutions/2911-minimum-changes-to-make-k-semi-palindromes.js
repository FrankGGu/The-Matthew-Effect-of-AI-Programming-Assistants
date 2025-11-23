var minimumChanges = function(s, k) {
    const n = s.length;

    const cost = Array(n).fill(0).map(() => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            cost[i][j] = calculateSemiPalindromeCost(s, i, j);
        }
    }

    const dp = Array(k + 1).fill(0).map(() => Array(n + 1).fill(Infinity));

    dp[0][0] = 0;

    for (let numParts = 1; numParts <= k; numParts++) {
        for (let endIndex = 1; endIndex <= n; endIndex++) {
            for (let prevEndIndex = 0; prevEndIndex < endIndex; prevEndIndex++) {
                if (dp[numParts - 1][prevEndIndex] !== Infinity) {
                    const currentSegmentCost = cost[prevEndIndex][endIndex - 1];
                    dp[numParts][endIndex] = Math.min(
                        dp[numParts][endIndex],
                        dp[numParts - 1][prevEndIndex] + currentSegmentCost
                    );
                }
            }
        }
    }

    return dp[k][n];
};

function calculateSemiPalindromeCost(s, start, end) {
    let changes = 0;
    let subLength = end - start + 1;

    if (subLength <= 1) {
        return 0;
    }

    for (let p = 0; p < Math.floor(subLength / 2); p++) {
        const char1 = s[start + p];
        const char2 = s[end - p]; 

        if (char1 !== char2) {
            if (char1 !== s[end - 1 - p]) {
                changes++;
            }
        }
    }
    return changes;
}