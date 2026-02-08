var maxTrailingZeros = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const count2 = Array(m).fill().map(() => Array(n).fill(0));
    const count5 = Array(m).fill().map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let num = grid[i][j];
            while (num % 2 === 0) {
                count2[i][j]++;
                num /= 2;
            }
            while (num % 5 === 0) {
                count5[i][j]++;
                num /= 5;
            }
        }
    }

    const prefix2Row = Array(m).fill().map(() => Array(n + 1).fill(0));
    const prefix5Row = Array(m).fill().map(() => Array(n + 1).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            prefix2Row[i][j + 1] = prefix2Row[i][j] + count2[i][j];
            prefix5Row[i][j + 1] = prefix5Row[i][j] + count5[i][j];
        }
    }

    const prefix2Col = Array(m + 1).fill().map(() => Array(n).fill(0));
    const prefix5Col = Array(m + 1).fill().map(() => Array(n).fill(0));
    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            prefix2Col[i + 1][j] = prefix2Col[i][j] + count2[i][j];
            prefix5Col[i + 1][j] = prefix5Col[i][j] + count5[i][j];
        }
    }

    let maxZeros = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const total2 = prefix2Row[i][j + 1] + prefix2Col[i][j];
            const total5 = prefix5Row[i][j + 1] + prefix5Col[i][j];
            maxZeros = Math.max(maxZeros, Math.min(total2, total5));

            const total2_2 = prefix2Row[i][j + 1] + (prefix2Col[m][j] - prefix2Col[i + 1][j]);
            const total5_2 = prefix5Row[i][j + 1] + (prefix5Col[m][j] - prefix5Col[i + 1][j]);
            maxZeros = Math.max(maxZeros, Math.min(total2_2, total5_2));

            const total2_3 = (prefix2Row[i][n] - prefix2Row[i][j]) + prefix2Col[i][j];
            const total5_3 = (prefix5Row[i][n] - prefix5Row[i][j]) + prefix5Col[i][j];
            maxZeros = Math.max(maxZeros, Math.min(total2_3, total5_3));

            const total2_4 = (prefix2Row[i][n] - prefix2Row[i][j]) + (prefix2Col[m][j] - prefix2Col[i + 1][j]);
            const total5_4 = (prefix5Row[i][n] - prefix5Row[i][j]) + (prefix5Col[m][j] - prefix5Col[i + 1][j]);
            maxZeros = Math.max(maxZeros, Math.min(total2_4, total5_4));
        }
    }

    return maxZeros;
};