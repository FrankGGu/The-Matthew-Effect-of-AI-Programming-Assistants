var bankBalance = function(balance, transactions) {
    let total = balance;
    for (let transaction of transactions) {
        total += transaction;
        if (total < 0) total = 0;
    }
    return total;
};