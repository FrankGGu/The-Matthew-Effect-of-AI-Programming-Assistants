var maxPoints = function(A) {
    const n = A.length, m = A[0].length;
    let maxSum = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            const first = A[i][j];
            let secondMax = 0;
            for (let k = 0; k < n; k++) {
                if (k !== i) {
                    for (let l = 0; l < m; l++) {
                        if (l !== j) {
                            secondMax = Math.max(secondMax, A[k][l]);
                        }
                    }
                }
            }
            let thirdMax = 0;
            for (let k = 0; k < n; k++) {
                if (k !== i) {
                    for (let l = 0; l < m; l++) {
                        if (l !== j) {
                            thirdMax = Math.max(thirdMax, A[k][l]);
                        }
                    }
                }
            }
            maxSum = Math.max(maxSum, first + secondMax + thirdMax);
        }
    }

    return maxSum;
};