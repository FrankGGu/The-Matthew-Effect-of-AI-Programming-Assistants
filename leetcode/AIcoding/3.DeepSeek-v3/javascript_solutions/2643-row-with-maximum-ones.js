var rowAndMaximumOnes = function(mat) {
    let maxRow = 0;
    let maxCount = 0;
    for (let i = 0; i < mat.length; i++) {
        const count = mat[i].reduce((a, b) => a + b, 0);
        if (count > maxCount) {
            maxCount = count;
            maxRow = i;
        }
    }
    return [maxRow, maxCount];
};