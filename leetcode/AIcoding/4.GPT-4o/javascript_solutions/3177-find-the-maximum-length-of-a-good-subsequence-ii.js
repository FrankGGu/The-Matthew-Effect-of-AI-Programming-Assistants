function maximumGood(statements) {
    const n = statements.length;
    let maxGoodLength = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        const goodPeople = [];
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                goodPeople.push(i);
            }
        }

        if (isValid(goodPeople, statements)) {
            maxGoodLength = Math.max(maxGoodLength, goodPeople.length);
        }
    }

    return maxGoodLength;
}

function isValid(goodPeople, statements) {
    const n = statements.length;
    const goodSet = new Set(goodPeople);

    for (const i of goodPeople) {
        for (let j = 0; j < n; j++) {
            if (statements[i][j] === 1 && !goodSet.has(j)) {
                return false;
            } else if (statements[i][j] === 0 && goodSet.has(j)) {
                return false;
            }
        }
    }

    return true;
}