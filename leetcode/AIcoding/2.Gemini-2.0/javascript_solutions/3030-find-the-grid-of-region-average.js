var resultGrid = function(image, threshold) {
    const m = image.length;
    const n = image[0].length;
    const grid = Array(m).fill(null).map(() => Array(n).fill(0));
    const count = Array(m).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i <= m - 3; i++) {
        for (let j = 0; j <= n - 3; j++) {
            let valid = true;
            for (let x = i; x < i + 3; x++) {
                for (let y = j; y < j + 3; y++) {
                    if (x > i && Math.abs(image[x][y] - image[x - 1][y]) > threshold) {
                        valid = false;
                        break;
                    }
                    if (y > j && Math.abs(image[x][y] - image[x][y - 1]) > threshold) {
                        valid = false;
                        break;
                    }
                }
                if (!valid) break;
            }

            if (valid) {
                let sum = 0;
                for (let x = i; x < i + 3; x++) {
                    for (let y = j; y < j + 3; y++) {
                        sum += image[x][y];
                    }
                }
                const avg = Math.floor(sum / 9);
                for (let x = i; x < i + 3; x++) {
                    for (let y = j; y < j + 3; y++) {
                        grid[x][y] += avg;
                        count[x][y]++;
                    }
                }
            }
        }
    }

    const res = Array(m).fill(null).map(() => Array(n).fill(-1));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (count[i][j] > 0) {
                res[i][j] = Math.floor(grid[i][j] / count[i][j]);
            }
        }
    }

    return res;
};