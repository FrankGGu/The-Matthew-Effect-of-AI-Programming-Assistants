var oddEvenTransactions = function(transactions) {
    let oddTransactions = [];
    let evenTransactions = [];
    let oddSum = 0;
    let evenSum = 0;

    for (let i = 0; i < transactions.length; i++) {
        if (transactions[i][1] % 2 === 0) {
            evenTransactions.push(transactions[i]);
            evenSum += transactions[i][1];
        } else {
            oddTransactions.push(transactions[i]);
            oddSum += transactions[i][1];
        }
    }

    if (evenSum > oddSum) {
        return evenTransactions;
    } else {
        return oddTransactions;
    }
};