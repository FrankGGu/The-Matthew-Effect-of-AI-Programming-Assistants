function maxSideLength(grid, threshold) {
    const m = grid.length;
    const n = grid[0].length;
    const prefix = new Array(m + 1).fill(0).map(() => new Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            prefix[i][j] = grid[i - 1][j - 1] + prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1];
        }
    }

    let maxLen = 0;
    let left = 1;
    let right = Math.min(m, n);

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        let found = false;

        for (let i = mid; i <= m; i++) {
            for (let j = mid; j <= n; j++) {
                const sum = prefix[i][j] - prefix[i - mid][j] - prefix[i][j - mid] + prefix[i - mid][j - mid];
                if (sum <= threshold) {
                    found = true;
                    break;
                }
            }
            if (found) break;
        }

        if (found) {
            maxLen = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return maxLen;
}