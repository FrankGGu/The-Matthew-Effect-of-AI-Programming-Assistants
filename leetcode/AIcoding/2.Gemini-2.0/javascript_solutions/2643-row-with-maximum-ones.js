var rowAndMaximumOnes = function(mat) {
    let maxOnes = -1;
    let rowIndex = -1;
    for (let i = 0; i < mat.length; i++) {
        let ones = 0;
        for (let j = 0; j < mat[i].length; j++) {
            if (mat[i][j] === 1) {
                ones++;
            }
        }
        if (ones > maxOnes) {
            maxOnes = ones;
            rowIndex = i;
        }
    }
    return [rowIndex, maxOnes];
};