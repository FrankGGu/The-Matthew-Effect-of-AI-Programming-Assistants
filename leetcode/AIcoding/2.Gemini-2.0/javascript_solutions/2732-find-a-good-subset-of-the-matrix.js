var goodSubsetofBinaryMatrix = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const seen = new Map();

    for (let i = 0; i < m; i++) {
        let num = 0;
        for (let j = 0; j < n; j++) {
            num = (num << 1) | matrix[i][j];
        }

        if (num === 0) {
            return [i];
        }

        seen.set(num, i);
    }

    for (let i = 0; i < m; i++) {
        let num1 = 0;
        for (let j = 0; j < n; j++) {
            num1 = (num1 << 1) | matrix[i][j];
        }

        for (let j = i + 1; j < m; j++) {
            let num2 = 0;
            for (let k = 0; k < n; k++) {
                num2 = (num2 << 1) | matrix[j][k];
            }

            if ((num1 & num2) === 0) {
                return [i, j];
            }
        }
    }

    return [];
};