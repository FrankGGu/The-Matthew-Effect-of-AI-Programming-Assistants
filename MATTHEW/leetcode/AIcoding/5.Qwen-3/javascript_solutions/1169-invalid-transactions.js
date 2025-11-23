function invalidTransactions(transactionList) {
    const result = [];
    const transactions = transactionList.map(t => t.split(','));

    for (let i = 0; i < transactions.length; i++) {
        const [name, time, amount, city] = transactions[i];
        if (parseInt(amount) > 1000) {
            result.push(transactionList[i]);
            continue;
        }
        let isInvalid = false;
        for (let j = 0; j < transactions.length; j++) {
            if (i === j) continue;
            const [otherName, otherTime, otherAmount, otherCity] = transactions[j];
            if (name === otherName && Math.abs(parseInt(time) - parseInt(otherTime)) <= 60 && city !== otherCity) {
                isInvalid = true;
                break;
            }
        }
        if (isInvalid) {
            result.push(transactionList[i]);
        }
    }
    return result;
}