function findPeakGrid(mat) {
    const binarySearch = (left, right) => {
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            let maxRowIdx = 0;
            for (let i = 1; i < mat.length; i++) {
                if (mat[i][mid] > mat[maxRowIdx][mid]) {
                    maxRowIdx = i;
                }
            }
            if (
                (mid === 0 || mat[maxRowIdx][mid] > mat[maxRowIdx][mid - 1]) &&
                (mid === mat[0].length - 1 || mat[maxRowIdx][mid] > mat[maxRowIdx][mid + 1])
            ) {
                return [maxRowIdx, mid];
            } else if (mid > 0 && mat[maxRowIdx][mid] < mat[maxRowIdx][mid - 1]) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
    };

    return binarySearch(0, mat[0].length - 1);
}