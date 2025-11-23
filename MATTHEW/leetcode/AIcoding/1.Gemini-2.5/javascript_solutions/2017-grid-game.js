var gridGame = function(grid) {
    const n = grid[0].length;

    const topSuffixSums = new Array(n).fill(0);
    const bottomPrefixSums = new Array(n).fill(0);

    topSuffixSums[n - 1] = grid[0][n - 1];
    for (let i = n - 2; i >= 0; i--) {
        topSuffixSums[i] = grid[0][i] + topSuffixSums[i + 1];
    }

    bottomPrefixSums[0] = grid[1][0];
    for (let i = 1; i < n; i++) {
        bottomPrefixSums[i] = grid[1][i] + bottomPrefixSums[i - 1];
    }

    let minMaxPoints = Infinity;

    for (let c = 0; c < n; c++) {
        let pointsFromTopRowForP2 = 0;
        if (c + 1 < n) {
            pointsFromTopRowForP2 = topSuffixSums[c + 1];
        }

        let pointsFromBottomRowForP2 = 0;
        if (c - 1 >= 0) {
            pointsFromBottomRowForP2 = bottomPrefixSums[c - 1];
        }

        const currentMaxForP2 = Math.max(pointsFromTopRowForP2, pointsFromBottomRowForP2);

        minMaxPoints = Math.min(minMaxPoints, currentMaxForP2);
    }

    return minMaxPoints;
};