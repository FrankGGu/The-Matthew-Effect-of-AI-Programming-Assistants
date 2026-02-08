function oddEvenTransactions(transactions) {
    let oddSum = 0, evenSum = 0;

    for (let i = 0; i < transactions.length; i++) {
        if (i % 2 === 0) {
            evenSum += transactions[i];
        } else {
            oddSum += transactions[i];
        }
    }

    return oddSum === evenSum;
}