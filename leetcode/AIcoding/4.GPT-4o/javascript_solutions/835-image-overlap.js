var largestOverlap = function(A, B) {
    const n = A.length;
    let maxOverlap = 0;

    const countOverlap = (offsetX, offsetY) => {
        let overlap = 0;
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                if (i + offsetX >= 0 && i + offsetX < n && j + offsetY >= 0 && j + offsetY < n) {
                    overlap += A[i][j] * B[i + offsetX][j + offsetY];
                }
            }
        }
        return overlap;
    };

    for (let offsetX = -n + 1; offsetX < n; offsetX++) {
        for (let offsetY = -n + 1; offsetY < n; offsetY++) {
            maxOverlap = Math.max(maxOverlap, countOverlap(offsetX, offsetY));
        }
    }

    return maxOverlap;
};