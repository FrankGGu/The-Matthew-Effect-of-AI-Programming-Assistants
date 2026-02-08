var maxSpending = function(values) {
    const allCosts = [];
    for (let i = 0; i < values.length; i++) {
        for (let j = 0; j < values[i].length; j++) {
            allCosts.push(values[i][j]);
        }
    }

    allCosts.sort((a, b) => a - b);

    let totalSpending = 0n;
    for (let i = 0; i < allCosts.length; i++) {
        totalSpending += BigInt(allCosts[i]) * BigInt(i + 1);
    }

    return Number(totalSpending);
};