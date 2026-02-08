var imageSmoother = function(img) {
    const m = img.length;
    const n = img[0].length;
    const result = new Array(m).fill().map(() => new Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let sum = 0;
            let count = 0;

            for (let x = i - 1; x <= i + 1; x++) {
                for (let y = j - 1; y <= j + 1; y++) {
                    if (x >= 0 && x < m && y >= 0 && y < n) {
                        sum += img[x][y];
                        count++;
                    }
                }
            }

            result[i][j] = Math.floor(sum / count);
        }
    }

    return result;
};