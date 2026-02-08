function bankAccountSummaryII(users, transactions) {
    const accountBalances = new Map();

    for (const transaction of transactions) {
        const currentBalance = accountBalances.get(transaction.account) || 0;
        accountBalances.set(transaction.account, currentBalance + transaction.amount);
    }

    const result = [];
    for (const user of users) {
        const balance = accountBalances.get(user.account) || 0;
        if (balance > 10000) {
            result.push({
                name: user.name,
                balance: balance
            });
        }
    }

    return result;
}