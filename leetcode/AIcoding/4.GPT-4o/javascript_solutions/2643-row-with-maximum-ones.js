function rowAndMaximumOnes(mat) {
    let maxRow = -1;
    let maxCount = 0;

    for (let i = 0; i < mat.length; i++) {
        let count = mat[i].reduce((a, b) => a + b, 0);
        if (count > maxCount) {
            maxCount = count;
            maxRow = i;
        } else if (count === maxCount) {
            maxRow = Math.max(maxRow, i);
        }
    }

    return [maxRow, maxCount];
}