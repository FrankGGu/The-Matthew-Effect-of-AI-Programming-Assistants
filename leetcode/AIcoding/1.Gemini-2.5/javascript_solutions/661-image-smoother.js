var imageSmoother = function(img) {
    const m = img.length;
    const n = img[0].length;
    const result = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            let sum = 0;
            let count = 0;

            for (let dr = -1; dr <= 1; dr++) {
                for (let dc = -1; dc <= 1; dc++) {
                    const nr = r + dr;
                    const nc = c + dc;

                    if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                        sum += img[nr][nc];
                        count++;
                    }
                }
            }
            result[r][c] = Math.floor(sum / count);
        }
    }

    return result;
};