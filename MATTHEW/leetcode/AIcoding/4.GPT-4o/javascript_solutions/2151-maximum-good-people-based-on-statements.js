var maximumGood = function(statements) {
    const n = statements.length;
    let maxGood = 0;

    const isValid = (mask) => {
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) continue;
            for (let j = 0; j < n; j++) {
                if (statements[i][j] === 2) continue;
                const expected = (mask & (1 << j)) > 0 ? 1 : 0;
                if (statements[i][j] !== expected) return false;
            }
        }
        return true;
    };

    const countGood = (mask) => {
        let count = 0;
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) count++;
        }
        return count;
    };

    for (let mask = 0; mask < (1 << n); mask++) {
        if (isValid(mask)) {
            maxGood = Math.max(maxGood, countGood(mask));
        }
    }

    return maxGood;
};