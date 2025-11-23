var minFlips = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let ans = Infinity;

    for (let mask = 0; mask < (1 << m); mask++) {
        let tempGrid = grid.map(row => [...row]);
        let flips = 0;

        for (let i = 0; i < m; i++) {
            if ((mask >> i) & 1) {
                flips++;
                for (let j = 0; j < n; j++) {
                    tempGrid[i][j] = 1 - tempGrid[i][j];
                }
            }
        }

        let isPalindrome = true;
        for (let j = 0; j < n; j++) {
            for (let i = 0; i < m; i++) {
                if (tempGrid[i][j] !== tempGrid[i][n - 1 - j]) {
                    isPalindrome = false;
                    break;
                }
            }
            if (!isPalindrome) break;
        }

        if (isPalindrome) {
            ans = Math.min(ans, flips);
        }
    }

    return ans === Infinity ? -1 : ans;
};