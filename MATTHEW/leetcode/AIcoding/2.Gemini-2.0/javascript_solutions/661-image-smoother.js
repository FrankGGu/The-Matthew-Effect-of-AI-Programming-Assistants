var imageSmoother = function(img) {
    const m = img.length;
    const n = img[0].length;
    const result = Array(m).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let sum = 0;
            let count = 0;

            for (let x = Math.max(0, i - 1); x <= Math.min(m - 1, i + 1); x++) {
                for (let y = Math.max(0, j - 1); y <= Math.min(n - 1, j + 1); y++) {
                    sum += img[x][y];
                    count++;
                }
            }

            result[i][j] = Math.floor(sum / count);
        }
    }

    return result;
};