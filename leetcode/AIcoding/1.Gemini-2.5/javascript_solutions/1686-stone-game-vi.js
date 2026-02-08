var stoneGameVI = function(aliceValues, bobValues) {
    const n = aliceValues.length;
    const piles = new Array(n);

    for (let i = 0; i < n; i++) {
        piles[i] = {
            aliceVal: aliceValues[i],
            bobVal: bobValues[i],
            sumVal: aliceValues[i] + bobValues[i]
        };
    }

    piles.sort((a, b) => b.sumVal - a.sumVal);

    let aliceScore = 0;
    let bobScore = 0;

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) { // Alice's turn
            aliceScore += piles[i].aliceVal;
        } else { // Bob's turn
            bobScore += piles[i].bobVal;
        }
    }

    return aliceScore - bobScore;
};