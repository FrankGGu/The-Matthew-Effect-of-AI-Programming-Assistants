var resultGrid = function(img, threshold) {
    const m = img.length;
    const n = img[0].length;
    const regions = Array.from({ length: m }, () => Array(n).fill([]));
    const counts = Array.from({ length: m }, () => Array(n).fill(0));

    for (let i = 0; i < m - 2; i++) {
        for (let j = 0; j < n - 2; j++) {
            let isRegion = true;
            for (let x = i; x < i + 3; x++) {
                for (let y = j; y < j + 3; y++) {
                    if (x > i && Math.abs(img[x][y] - img[x - 1][y]) > threshold) {
                        isRegion = false;
                    }
                    if (y > j && Math.abs(img[x][y] - img[x][y - 1]) > threshold) {
                        isRegion = false;
                    }
                }
            }
            if (isRegion) {
                let sum = 0;
                for (let x = i; x < i + 3; x++) {
                    for (let y = j; y < j + 3; y++) {
                        sum += img[x][y];
                    }
                }
                const avg = Math.floor(sum / 9);
                for (let x = i; x < i + 3; x++) {
                    for (let y = j; y < j + 3; y++) {
                        regions[x][y] = regions[x][y].concat(avg);
                        counts[x][y]++;
                    }
                }
            }
        }
    }

    const result = Array.from({ length: m }, () => Array(n).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (counts[i][j] === 0) {
                result[i][j] = img[i][j];
            } else {
                const sum = regions[i][j].reduce((a, b) => a + b, 0);
                result[i][j] = Math.floor(sum / counts[i][j]);
            }
        }
    }

    return result;
};