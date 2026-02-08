var maximumGood = function(A) {
    let n = A.length;
    let maxGoodSum = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        let goodSum = 0;
        let valid = true;

        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                goodSum += A[i];
            } else {
                if (A[i] === 1) {
                    valid = false;
                    break;
                }
            }
        }

        if (valid) {
            maxGoodSum = Math.max(maxGoodSum, goodSum);
        }
    }

    return maxGoodSum;
};