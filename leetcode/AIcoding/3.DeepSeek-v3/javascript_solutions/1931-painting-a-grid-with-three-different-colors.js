const colorTheGrid = function(m, n) {
    const MOD = 1e9 + 7;
    const memo = new Map();

    const dfs = (prevRow, currentCol) => {
        if (currentCol === n) return 1;
        const key = `${prevRow},${currentCol}`;
        if (memo.has(key)) return memo.get(key);

        let total = 0;
        const generateNextRow = (currentRow, pos) => {
            if (pos === m) {
                let valid = true;
                for (let i = 0; i < m; i++) {
                    if (currentRow[i] === prevRow[i]) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    total = (total + dfs(currentRow, currentCol + 1)) % MOD;
                }
                return;
            }

            for (let color = 0; color < 3; color++) {
                if (pos > 0 && currentRow[pos - 1] === color) continue;
                const newRow = currentRow.slice();
                newRow[pos] = color;
                generateNextRow(newRow, pos + 1);
            }
        };

        generateNextRow(new Array(m).fill(-1), 0);
        memo.set(key, total);
        return total;
    };

    return dfs(new Array(m).fill(-1), 0);
};