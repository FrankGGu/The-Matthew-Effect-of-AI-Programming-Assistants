var maxTrailingZeros = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const rowsTwo = Array(m).fill(null).map(() => Array(n).fill(0));
    const rowsFive = Array(m).fill(null).map(() => Array(n).fill(0));
    const colsTwo = Array(n).fill(null).map(() => Array(m).fill(0));
    const colsFive = Array(n).fill(null).map(() => Array(m).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let num = grid[i][j];
            while (num % 2 === 0 && num > 0) {
                rowsTwo[i][j]++;
                num /= 2;
            }
            num = grid[i][j];
            while (num % 5 === 0 && num > 0) {
                rowsFive[i][j]++;
                num /= 5;
            }
        }
    }

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            let num = grid[i][j];
            while (num % 2 === 0 && num > 0) {
                colsTwo[j][i]++;
                num /= 2;
            }
            num = grid[i][j];
            while (num % 5 === 0 && num > 0) {
                colsFive[j][i]++;
                num /= 5;
            }
        }
    }

    let maxZeros = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let twoCount = 0;
            let fiveCount = 0;

            twoCount += rowsTwo[i][j];
            fiveCount += rowsFive[i][j];

            let rowTwoSum = 0;
            let rowFiveSum = 0;
            for (let k = 0; k < n; k++) {
                rowTwoSum += rowsTwo[i][k];
                rowFiveSum += rowsFive[i][k];
            }

            let colTwoSum = 0;
            let colFiveSum = 0;
            for (let k = 0; k < m; k++) {
                colTwoSum += colsTwo[j][k];
                colFiveSum += colsFive[j][k];
            }

            let two1 = rowTwoSum + colTwoSum - rowsTwo[i][j];
            let five1 = rowFiveSum + colFiveSum - rowsFive[i][j];
            maxZeros = Math.max(maxZeros, Math.min(two1, five1));

             let two2 = rowTwoSum  + (colTwoSum - colsTwo[j][i]) - rowsTwo[i][j];
            let five2 = rowFiveSum + (colFiveSum - colsFive[j][i]) - rowsFive[i][j];

            maxZeros = Math.max(maxZeros, Math.min(two2, five2));

             let two3 = colTwoSum  + (rowTwoSum - rowsTwo[i][j]) - colsTwo[j][i];
            let five3 = colFiveSum + (rowFiveSum - rowsFive[i][j]) - colsFive[j][i];
            maxZeros = Math.max(maxZeros, Math.min(two3, five3));

        }
    }

    return maxZeros;
};