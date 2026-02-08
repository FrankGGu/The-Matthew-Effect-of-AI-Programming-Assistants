var getBiggestThree = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const sums = new Set();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            sums.add(grid[i][j]);
            let k = 1;
            while (i - k >= 0 && i + k < m && j - k >= 0 && j + k < n) {
                let sum = 0;
                let x = i - k, y = j;
                for (let l = 0; l < k; l++) {
                    sum += grid[x++][y--];
                }
                for (let l = 0; l < k; l++) {
                    sum += grid[x++][y++];
                }
                for (let l = 0; l < k; l++) {
                    sum += grid[x--][y++];
                }
                for (let l = 0; l < k; l++) {
                    sum += grid[x--][y--];
                }
                sums.add(sum);
                k++;
            }
        }
    }

    const sorted = Array.from(sums).sort((a, b) => b - a);
    return sorted.slice(0, 3);
};