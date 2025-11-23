var rowAndMaximumOnes = function(mat) {
    let maxOnesCount = 0;
    let resultRowIndex = 0;

    for (let i = 0; i < mat.length; i++) {
        let currentOnesCount = 0;
        for (let j = 0; j < mat[i].length; j++) {
            if (mat[i][j] === 1) {
                currentOnesCount++;
            }
        }

        if (currentOnesCount > maxOnesCount) {
            maxOnesCount = currentOnesCount;
            resultRowIndex = i;
        }
    }

    return [resultRowIndex, maxOnesCount];
};