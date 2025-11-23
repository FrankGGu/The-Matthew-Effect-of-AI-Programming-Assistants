var invalidTransactions = function(transactions) {
    const parsedTransactions = [];
    for (let i = 0; i < transactions.length; i++) {
        const parts = transactions[i].split(',');
        parsedTransactions.push({
            name: parts[0],
            time: parseInt(parts[1]),
            amount: parseInt(parts[2]),
            city: parts[3],
            original: transactions[i]
        });
    }

    const invalidSet = new Set();

    for (let i = 0; i < parsedTransactions.length; i++) {
        const t1 = parsedTransactions[i];

        if (t1.amount > 1000) {
            invalidSet.add(t1.original);
        }

        for (let j = 0; j < parsedTransactions.length; j++) {
            const t2 = parsedTransactions[j];

            if (t1.name === t2.name &&
                t1.city !== t2.city &&
                Math.abs(t1.time - t2.time) <= 60) {

                invalidSet.add(t1.original);
                invalidSet.add(t2.original);
            }
        }
    }

    return Array.from(invalidSet);
};