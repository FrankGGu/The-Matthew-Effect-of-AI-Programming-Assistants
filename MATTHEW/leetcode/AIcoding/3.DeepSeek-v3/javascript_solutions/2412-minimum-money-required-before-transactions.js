var minimumMoney = function(transactions) {
    let totalLoss = 0;
    let maxCashback = 0;
    let maxCost = 0;

    for (const [cost, cashback] of transactions) {
        if (cost > cashback) {
            totalLoss += cost - cashback;
            maxCashback = Math.max(maxCashback, cashback);
        } else {
            maxCost = Math.max(maxCost, cost);
        }
    }

    return totalLoss + Math.max(maxCashback, maxCost);
};