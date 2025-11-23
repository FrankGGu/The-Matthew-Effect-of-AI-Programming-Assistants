function invalidTransactions(transactions) {
    const invalid = new Set();
    const n = transactions.length;
    const records = [];

    for (let i = 0; i < n; i++) {
        const [name, time, amount, city] = transactions[i].split(',');
        records.push({ name, time: parseInt(time), amount: parseInt(amount), city });
    }

    for (let i = 0; i < n; i++) {
        const { name, time, amount, city } = records[i];
        if (amount > 1000) {
            invalid.add(transactions[i]);
        }
        for (let j = 0; j < n; j++) {
            if (i !== j && records[i].name === records[j].name && Math.abs(records[i].time - records[j].time) <= 60 && records[i].city !== records[j].city) {
                invalid.add(transactions[i]);
                invalid.add(transactions[j]);
            }
        }
    }

    return Array.from(invalid);
}