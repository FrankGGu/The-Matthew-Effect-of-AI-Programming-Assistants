var maxTrailingZeros = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const countFactors = (num, factor) => {
        let count = 0;
        while (num > 0 && num % factor === 0) {
            count++;
            num /= factor;
        }
        return count;
    };

    const twos = Array(m).fill(0).map(() => Array(n).fill(0));
    const fives = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            twos[r][c] = countFactors(grid[r][c], 2);
            fives[r][c] = countFactors(grid[r][c], 5);
        }
    }

    const rowTwosPrefix = Array(m).fill(0).map(() => Array(n).fill(0));
    const rowFivesPrefix = Array(m).fill(0).map(() => Array(n).fill(0));
    const colTwosPrefix = Array(m).fill(0).map(() => Array(n).fill(0));
    const colFivesPrefix = Array(m).fill(0).map(() => Array(n).fill(0));

    const rowTwosSuffix = Array(m).fill(0).map(() => Array(n).fill(0));
    const rowFivesSuffix = Array(m).fill(0).map(() => Array(n).fill(0));
    const colTwosSuffix = Array(m).fill(0).map(() => Array(n).fill(0));
    const colFivesSuffix = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            rowTwosPrefix[r][c] = twos[r][c] + (c > 0 ? rowTwosPrefix[r][c - 1] : 0);
            rowFivesPrefix[r][c] = fives[r][c] + (c > 0 ? rowFivesPrefix[r][c - 1] : 0);
        }
    }

    for (let c = 0; c < n; c++) {
        for (let r = 0; r < m; r++) {
            colTwosPrefix[r][c] = twos[r][c] + (r > 0 ? colTwosPrefix[r - 1][c] : 0);
            colFivesPrefix[r][c] = fives[r][c] + (r > 0 ? colFivesPrefix[r - 1][c] : 0);
        }
    }

    for (let r = 0; r < m; r++) {
        for (let c = n - 1; c >= 0; c--) {
            rowTwosSuffix[r][c] = twos[r][c] + (c < n - 1 ? rowTwosSuffix[r][c + 1] : 0);
            rowFivesSuffix[r][c] = fives[r][c] + (c < n - 1 ? rowFivesSuffix[r][c + 1] : 0);
        }
    }

    for (let c = 0; c < n; c++) {
        for (let r = m - 1; r >= 0; r--) {
            colTwosSuffix[r][c] = twos[r][c] + (r < m - 1 ? colTwosSuffix[r + 1][c] : 0);
            colFivesSuffix[r][c] = fives[r][c] + (r < m - 1 ? colFivesSuffix[r + 1][c] : 0);
        }
    }

    let maxZeros = 0;

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            const t2 = twos[r][c];
            const f5 = fives[r][c];

            // Path 1: Horizontal Left (to c) + Vertical Up (to r)
            let currentTwos = rowTwosPrefix[r][c] + colTwosPrefix[r][c] - t2;
            let currentFives = rowFivesPrefix[r][c] + colFivesPrefix[r][c] - f5;
            maxZeros = Math.max(maxZeros, Math.min(currentTwos, currentFives));

            // Path 2: Horizontal Left (to c) + Vertical Down (to r)
            currentTwos = rowTwosPrefix[r][c] + colTwosSuffix[r][c] - t2;
            currentFives = rowFivesPrefix[r][c] + colFivesSuffix[r][c] - f5;
            maxZeros = Math.max(maxZeros, Math.min(currentTwos, currentFives));

            // Path 3: Horizontal Right (to c) + Vertical Up (to r)
            currentTwos = rowTwosSuffix[r][c] + colTwosPrefix[r][c] - t2;
            currentFives = rowFivesSuffix[r][c] + colFivesPrefix[r][c] - f5;
            maxZeros = Math.max(maxZeros, Math.min(currentTwos, currentFives));

            // Path 4: Horizontal Right (to c) + Vertical Down (to r)
            currentTwos = rowTwosSuffix[r][c] + colTwosSuffix[r][c] - t2;
            currentFives = rowFivesSuffix[r][c] + colFivesSuffix[r][c] - f5;
            maxZeros = Math.max(maxZeros, Math.min(currentTwos, currentFives));
        }
    }

    return maxZeros;
};