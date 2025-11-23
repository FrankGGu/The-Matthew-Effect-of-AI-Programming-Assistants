var minimumMoney = function(transactions) {
    let ans = 0; // The minimum initial money required
    let currentMoney = 0; // The money we currently have after completing previous transactions

    const profitableTransactions = []; // Transactions where cost <= cashback
    const lossyTransactions = [];     // Transactions where cost > cashback

    // Separate transactions into two groups
    for (const [cost, cashback] of transactions) {
        if (cost <= cashback) {
            profitableTransactions.push([cost, cashback]);
        } else {
            lossyTransactions.push([cost, cashback]);
        }
    }

    // Sort profitable transactions by their cost in ascending order.
    // This ensures we attempt to complete transactions with lower cost requirements first,
    // which is beneficial as these transactions increase or maintain our money.
    profitableTransactions.sort((a, b) => a[0] - b[0]);

    // Sort lossy transactions by their cashback in descending order.
    // For lossy transactions, we want to maximize the money returned as early as possible
    // to mitigate the overall decrease in our money.
    lossyTransactions.sort((a, b) => b[1] - a[1]);

    // The optimal strategy is to process all lossy transactions first, then all profitable ones.
    // Lossy transactions are the ones that can deplete our money, so handling them first helps
    // determine the peak money requirement. Profitable transactions then replenish money,
    // making it easier to cover subsequent costs.
    const orderedTransactions = [...lossyTransactions, ...profitableTransactions];

    // Iterate through the ordered transactions
    for (const [cost, cashback] of orderedTransactions) {
        // If our current money is less than the cost of the current transaction,
        // we need to increase our initial money (ans) to cover this deficit.
        if (currentMoney < cost) {
            ans += (cost - currentMoney);
            // After adding to 'ans', we effectively have 'cost' money to start this transaction.
            currentMoney = cost; 
        }

        // Pay the cost of the transaction
        currentMoney -= cost;
        // Receive the cashback
        currentMoney += cashback;
    }

    return ans;
};