var invalidTransactions = function(transactions) {
    const map = {};
    const invalid = new Set();

    for (let i = 0; i < transactions.length; i++) {
        const [name, time, amount, city] = transactions[i].split(',');

        if (amount > 1000) {
            invalid.add(i);
        }

        if (!map[name]) {
            map[name] = [];
        }

        map[name].push({ time: parseInt(time), city, index: i });
    }

    for (const name in map) {
        const list = map[name];
        list.sort((a, b) => a.time - b.time);

        for (let i = 0; i < list.length; i++) {
            const curr = list[i];
            let j = i - 1;

            while (j >= 0 && curr.time - list[j].time <= 60) {
                if (curr.city !== list[j].city) {
                    invalid.add(curr.index);
                    invalid.add(list[j].index);
                }
                j--;
            }

            j = i + 1;
            while (j < list.length && list[j].time - curr.time <= 60) {
                if (curr.city !== list[j].city) {
                    invalid.add(curr.index);
                    invalid.add(list[j].index);
                }
                j++;
            }
        }
    }

    return Array.from(invalid).map(i => transactions[i]);
};