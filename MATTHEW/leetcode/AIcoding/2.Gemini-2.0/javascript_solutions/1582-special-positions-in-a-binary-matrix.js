var numSpecial = function(mat) {
    let count = 0;
    const rows = mat.length;
    const cols = mat[0].length;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (mat[i][j] === 1) {
                let rowSum = 0;
                for (let k = 0; k < cols; k++) {
                    rowSum += mat[i][k];
                }

                let colSum = 0;
                for (let k = 0; k < rows; k++) {
                    colSum += mat[k][j];
                }

                if (rowSum === 1 && colSum === 1) {
                    count++;
                }
            }
        }
    }

    return count;
};