var oddEvenTransactions = function(transactions) {
    let oddSum = 0;
    let evenSum = 0;

    for (let i = 0; i < transactions.length; i++) {
        const amount = transactions[i].amount;
        if (amount % 2 === 0) {
            evenSum += amount;
        } else {
            oddSum += amount;
        }
    }

    return [oddSum, evenSum];
};