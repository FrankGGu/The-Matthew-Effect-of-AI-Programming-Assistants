var solve = function(nums, queries) {
    let maxVal = 0;
    for (let x of nums) {
        if (x > maxVal) {
            maxVal = x;
        }
    }

    const freq = new Array(maxVal + 1).fill(0);
    for (let x of nums) {
        freq[x]++;
    }

    const numPairsMultipleOfG = new Array(maxVal + 1).fill(0);
    for (let g = 1; g <= maxVal; g++) {
        let currentMultiplesCount = 0;
        for (let m = g; m <= maxVal; m += g) {
            currentMultiplesCount += freq[m];
        }
        numPairsMultipleOfG[g] = currentMultiplesCount * (currentMultiplesCount - 1) / 2;
    }

    const numPairsGcdIsG = new Array(maxVal + 1).fill(0);
    for (let g = maxVal; g >= 1; g--) {
        numPairsGcdIsG[g] = numPairsMultipleOfG[g];
        for (let k = 2 * g; k <= maxVal; k += g) {
            numPairsGcdIsG[g] -= numPairsGcdIsG[k];
        }
    }

    const ansForQueryK = new Array(maxVal + 2).fill(0);
    for (let k = maxVal; k >= 1; k--) {
        ansForQueryK[k] = ansForQueryK[k + 1] + numPairsGcdIsG[k];
    }

    const result = [];
    for (let i = 0; i < queries.length; i++) {
        const queryLimit = queries[i][0];
        if (queryLimit > maxVal) {
            result.push(0);
        } else {
            result.push(ansForQueryK[queryLimit]);
        }
    }

    return result;
};