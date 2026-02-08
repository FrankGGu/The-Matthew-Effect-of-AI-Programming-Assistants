var numSpecial = function(mat) {
    const m = mat.length;
    const n = mat[0].length;

    const rowSums = new Array(m).fill(0);
    const colSums = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] === 1) {
                rowSums[i]++;
                colSums[j]++;
            }
        }
    }

    let specialPositions = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] === 1 && rowSums[i] === 1 && colSums[j] === 1) {
                specialPositions++;
            }
        }
    }

    return specialPositions;
};