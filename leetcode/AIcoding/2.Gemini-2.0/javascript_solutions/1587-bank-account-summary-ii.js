var transactionBalances = function(balance, transactions) {
    const accountBalances = new Map();
    for (let i = 0; i < balance.length; i++) {
        accountBalances.set(i + 1, balance[i]);
    }

    for (const transaction of transactions) {
        const account = transaction[0];
        const money = transaction[1];
        accountBalances.set(account, accountBalances.get(account) + money);
    }

    const result = [];
    for (let i = 1; i <= balance.length; i++) {
        result.push(accountBalances.get(i));
    }

    return result;
};