var invalidTransactions = function(transactions) {
    const invalid = new Set();
    const transactionMap = new Map();

    for (let i = 0; i < transactions.length; i++) {
        const [name, time, amount, city] = transactions[i].split(',');
        if (parseInt(amount) > 1000) {
            invalid.add(i);
        }
        if (!transactionMap.has(name)) {
            transactionMap.set(name, []);
        }
        transactionMap.get(name).push({ time: parseInt(time), city, index: i });
    }

    for (const [name, entries] of transactionMap) {
        entries.sort((a, b) => a.time - b.time);
        for (let i = 0; i < entries.length; i++) {
            const current = entries[i];
            for (let j = i + 1; j < entries.length; j++) {
                const next = entries[j];
                if (next.time - current.time > 60) break;
                if (next.city !== current.city) {
                    invalid.add(current.index);
                    invalid.add(next.index);
                }
            }
        }
    }

    return Array.from(invalid).map(i => transactions[i]);
};