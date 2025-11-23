var minimumMoney = function(transactions) {
    let loss = 0;
    let gain = 0;
    let maxLoss = 0;

    const positiveTransactions = [];
    const negativeTransactions = [];

    for (const transaction of transactions) {
        const cost = transaction[0];
        const cashback = transaction[1];

        if (cost > cashback) {
            loss += cost - cashback;
            maxLoss = Math.max(maxLoss, cost);
            negativeTransactions.push(transaction);
        } else {
            gain += cashback - cost;
            positiveTransactions.push(transaction);
        }
    }

    negativeTransactions.sort((a, b) => b[0] - a[0]);

    let requiredMoney = 0;

    for(const transaction of negativeTransactions){
        requiredMoney = Math.max(requiredMoney, transaction[0]);
    }

    let ans = 0;
    if(negativeTransactions.length > 0){
        ans = requiredMoney + loss;
    }

    for(const transaction of positiveTransactions){
        if(negativeTransactions.length === 0){
            ans = Math.max(ans, transaction[0]);
        }
    }

    if(negativeTransactions.length === 0 && positiveTransactions.length === 0){
        return 0;
    }

    if(negativeTransactions.length === 0 && positiveTransactions.length > 0){
        let maxCost = 0;
        for(const transaction of positiveTransactions){
            maxCost = Math.max(maxCost, transaction[0]);
        }
        return maxCost;
    }

    return requiredMoney;
};