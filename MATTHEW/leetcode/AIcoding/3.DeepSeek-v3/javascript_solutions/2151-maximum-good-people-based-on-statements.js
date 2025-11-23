var maximumGood = function(statements) {
    const n = statements.length;
    let maxGood = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        let isValid = true;
        for (let i = 0; i < n && isValid; i++) {
            if ((mask & (1 << i)) === 0) continue;
            for (let j = 0; j < n && isValid; j++) {
                const val = statements[i][j];
                if (val === 2) continue;
                const expected = (mask & (1 << j)) ? 1 : 0;
                if (val !== expected) isValid = false;
            }
        }
        if (isValid) {
            const count = mask.toString(2).split('1').length - 1;
            maxGood = Math.max(maxGood, count);
        }
    }

    return maxGood;
};