var findPeakGrid = function(mat) {
    const m = mat.length;
    const n = mat[0].length;

    let left = 0;
    let right = n - 1;

    while (left <= right) {
        let midCol = Math.floor((left + right) / 2);

        let maxRow = 0;
        for (let r = 1; r < m; r++) {
            if (mat[r][midCol] > mat[maxRow][midCol]) {
                maxRow = r;
            }
        }

        const currentVal = mat[maxRow][midCol];

        const leftNeighborVal = (midCol > 0) ? mat[maxRow][midCol - 1] : -1;
        const rightNeighborVal = (midCol < n - 1) ? mat[maxRow][midCol + 1] : -1;

        if (currentVal > leftNeighborVal && currentVal > rightNeighborVal) {
            return [maxRow, midCol];
        } else if (currentVal < leftNeighborVal) {
            right = midCol - 1;
        } else {
            left = midCol + 1;
        }
    }
};