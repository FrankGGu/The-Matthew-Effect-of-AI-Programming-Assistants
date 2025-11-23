var maxArea = function(A) {
    let n = A.length, m = A[0].length;
    let minDimension = Math.min(n, m);

    for (let size = minDimension; size >= 1; size--) {
        for (let i = 0; i <= n - size; i++) {
            for (let j = 0; j <= m - size; j++) {
                let valid = true;
                for (let x = i; x < i + size; x++) {
                    for (let y = j; y < j + size; y++) {
                        if (A[x][y] === 1) {
                            valid = false;
                            break;
                        }
                    }
                    if (!valid) break;
                }
                if (valid) return size * size;
            }
        }
    }
    return 0;
};