var minimumMoney = function(transactions) {
    let total = 0;
    let need = 0;

    for (const [cost, cashback] of transactions) {
        total += Math.max(0, cost - cashback);
        need = Math.max(need, cost - cashback);
    }

    return total + need;
};