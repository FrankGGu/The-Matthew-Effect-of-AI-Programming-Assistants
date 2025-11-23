function getBiggestThree(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let max = 0;
            let k = 0;
            while (true) {
                let sum = 0;
                let x = i - k;
                let y = j;
                for (let d = 0; d < 4; d++) {
                    for (let l = 0; l < k; l++) {
                        if (d === 0) x++;
                        else if (d === 1) y++;
                        else if (d === 2) x--;
                        else if (d === 3) y--;
                        if (x < 0 || x >= m || y < 0 || y >= n) break;
                        sum += grid[x][y];
                    }
                }
                if (sum === 0 && k === 0) {
                    sum = grid[i][j];
                }
                if (sum === 0) break;
                if (result.length < 3) {
                    result.push(sum);
                } else {
                    if (sum > result[0]) {
                        result[0] = sum;
                    } else if (sum > result[1]) {
                        result[1] = sum;
                    } else if (sum > result[2]) {
                        result[2] = sum;
                    }
                }
                k++;
            }
        }
    }

    result.sort((a, b) => b - a);
    return result.slice(0, 3);
}