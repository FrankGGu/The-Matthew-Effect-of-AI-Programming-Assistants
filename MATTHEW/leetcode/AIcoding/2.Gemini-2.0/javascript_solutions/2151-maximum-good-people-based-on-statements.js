var maximumGood = function(statements) {
    const n = statements.length;
    let maxGood = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        let goodCount = 0;
        let consistent = true;

        for (let i = 0; i < n; i++) {
            if ((mask >> i) & 1) {
                goodCount++;
            }
        }

        for (let i = 0; i < n; i++) {
            if ((mask >> i) & 1) {
                for (let j = 0; j < n; j++) {
                    if (statements[i][j] !== 2) {
                        let statementTruth = ((mask >> j) & 1);
                        if (statements[i][j] !== statementTruth) {
                            consistent = false;
                            break;
                        }
                    }
                }
            }
            if (!consistent) break;
        }

        if (consistent) {
            maxGood = Math.max(maxGood, goodCount);
        }
    }

    return maxGood;
};