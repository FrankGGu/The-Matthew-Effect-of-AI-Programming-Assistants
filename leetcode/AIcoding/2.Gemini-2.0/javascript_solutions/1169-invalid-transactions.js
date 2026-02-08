var invalidTransactions = function(transactions) {
    const n = transactions.length;
    const invalid = new Array(n).fill(false);
    const transactionList = [];

    for (let i = 0; i < n; i++) {
        const [name1, time1, amount1, city1] = transactions[i].split(',');
        transactionList.push({ name: name1, time: parseInt(time1), amount: parseInt(amount1), city: city1, index: i });
        if (parseInt(amount1) > 1000) {
            invalid[i] = true;
        }
    }

    for (let i = 0; i < n; i++) {
        const { name: name1, time: time1, city: city1, index: index1 } = transactionList[i];
        for (let j = i + 1; j < n; j++) {
            const { name: name2, time: time2, city: city2, index: index2 } = transactionList[j];
            if (name1 === name2 && Math.abs(time1 - time2) <= 60 && city1 !== city2) {
                invalid[index1] = true;
                invalid[index2] = true;
            }
        }
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        if (invalid[i]) {
            result.push(transactions[i]);
        }
    }

    return result;
};