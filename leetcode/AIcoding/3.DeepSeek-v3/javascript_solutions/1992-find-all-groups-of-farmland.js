var findFarmland = function(land) {
    const result = [];
    const m = land.length;
    const n = land[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (land[i][j] === 1) {
                let r1 = i, c1 = j;
                let r2 = i, c2 = j;

                while (r2 < m && land[r2][j] === 1) {
                    r2++;
                }
                r2--;

                while (c2 < n && land[i][c2] === 1) {
                    c2++;
                }
                c2--;

                for (let x = r1; x <= r2; x++) {
                    for (let y = c1; y <= c2; y++) {
                        land[x][y] = 0;
                    }
                }

                result.push([r1, c1, r2, c2]);
            }
        }
    }

    return result;
};