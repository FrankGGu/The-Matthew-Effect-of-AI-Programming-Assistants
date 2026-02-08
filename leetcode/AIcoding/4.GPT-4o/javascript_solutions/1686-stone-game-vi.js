var stoneGameVI = function(aliceValues, bobValues) {
    const n = aliceValues.length;
    const valuePairs = [];

    for (let i = 0; i < n; i++) {
        valuePairs.push([aliceValues[i] + bobValues[i], aliceValues[i], bobValues[i]]);
    }

    valuePairs.sort((a, b) => b[0] - a[0]);

    let aliceScore = 0, bobScore = 0;

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            aliceScore += valuePairs[i][1];
        } else {
            bobScore += valuePairs[i][2];
        }
    }

    if (aliceScore > bobScore) return 1;
    if (aliceScore < bobScore) return -1;
    return 0;
};