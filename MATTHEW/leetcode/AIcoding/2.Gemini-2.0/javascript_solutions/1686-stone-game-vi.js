var stoneGameVI = function(aliceValues, bobValues) {
    const n = aliceValues.length;
    const combinedValues = [];
    for (let i = 0; i < n; i++) {
        combinedValues.push([aliceValues[i] + bobValues[i], i]);
    }

    combinedValues.sort((a, b) => b[0] - a[0]);

    let aliceScore = 0;
    let bobScore = 0;

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            aliceScore += aliceValues[combinedValues[i][1]];
        } else {
            bobScore += bobValues[combinedValues[i][1]];
        }
    }

    if (aliceScore > bobScore) {
        return 1;
    } else if (aliceScore < bobScore) {
        return -1;
    } else {
        return 0;
    }
};