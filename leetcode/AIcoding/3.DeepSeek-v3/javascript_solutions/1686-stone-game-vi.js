var stoneGameVI = function(aliceValues, bobValues) {
    const n = aliceValues.length;
    const stones = [];
    for (let i = 0; i < n; i++) {
        stones.push([aliceValues[i] + bobValues[i], aliceValues[i], bobValues[i]]);
    }
    stones.sort((a, b) => b[0] - a[0]);

    let aliceScore = 0;
    let bobScore = 0;
    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            aliceScore += stones[i][1];
        } else {
            bobScore += stones[i][2];
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