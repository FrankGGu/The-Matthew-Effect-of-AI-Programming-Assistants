function countSubmatrices(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let count = 0;

    for (let i = 0; i < m; i++) {
        const row = new Array(n).fill(0);
        for (let j = i; j < m; j++) {
            for (let k = 0; k < n; k++) {
                if (grid[j][k] === 'X') row[k]++;
                else if (grid[j][k] === 'Y') row[k]--;
            }

            let sum = 0;
            const prefixSum = new Map();
            prefixSum.set(0, 1);
            for (let k = 0; k < n; k++) {
                sum += row[k];
                if (prefixSum.has(sum)) {
                    count += prefixSum.get(sum);
                }
                prefixSum.set(sum, (prefixSum.get(sum) || 0) + 1);
            }
        }
    }

    return count;
}