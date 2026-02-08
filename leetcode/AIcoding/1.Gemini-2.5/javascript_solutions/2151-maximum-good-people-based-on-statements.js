var maximumGoodPeople = function(statements) {
    const n = statements.length;
    let maxGood = 0;

    for (let i = 0; i < (1 << n); i++) {
        let currentGoodCount = 0;
        let isValid = true;

        for (let p1 = 0; p1 < n; p1++) {
            const p1IsGood = (i >> p1) & 1;

            if (p1IsGood) {
                currentGoodCount++;
                for (let p2 = 0; p2 < n; p2++) {
                    const statement = statements[p1][p2];
                    if (statement === 0) {
                        if (((i >> p2) & 1) === 1) {
                            isValid = false;
                            break;
                        }
                    } else if (statement === 1) {
                        if (((i >> p2) & 1) === 0) {
                            isValid = false;
                            break;
                        }
                    }
                }
            }
            if (!isValid) {
                break;
            }
        }

        if (isValid) {
            maxGood = Math.max(maxGood, currentGoodCount);
        }
    }

    return maxGood;
};