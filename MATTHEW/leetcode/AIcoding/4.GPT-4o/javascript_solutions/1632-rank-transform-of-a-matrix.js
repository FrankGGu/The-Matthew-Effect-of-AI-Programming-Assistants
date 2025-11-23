var matrixRankTransform = function(matrix) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    const rank = Array.from({ length: rows + cols }, () => 0);
    const sorted = [];

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            sorted.push([matrix[r][c], r, c]);
        }
    }

    sorted.sort((a, b) => a[0] - b[0]);
    const result = Array.from({ length: rows }, () => Array(cols).fill(0));

    for (let i = 0; i < sorted.length; i++) {
        const [val, r, c] = sorted[i];
        const rowRank = rank[r];
        const colRank = rank[cols + c];
        const currentRank = Math.max(rowRank, colRank) + 1;
        result[r][c] = currentRank;
        rank[r] = currentRank;
        rank[cols + c] = currentRank;
    }

    return result;
};