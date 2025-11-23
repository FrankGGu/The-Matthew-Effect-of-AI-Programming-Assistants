var findRecommendationPairs = function(transactions, k) {
    const pairCounts = new Map();

    for (const transaction of transactions) {
        const uniqueSortedTransaction = Array.from(new Set(transaction)).sort((a, b) => a - b);

        for (let i = 0; i < uniqueSortedTransaction.length; i++) {
            for (let j = i + 1; j < uniqueSortedTransaction.length; j++) {
                const p1 = uniqueSortedTransaction[i];
                const p2 = uniqueSortedTransaction[j];
                const key = `${p1},${p2}`;

                pairCounts.set(key, (pairCounts.get(key) || 0) + 1);
            }
        }
    }

    const result = [];

    for (const [key, count] of pairCounts.entries()) {
        if (count >= k) {
            const [p1Str, p2Str] = key.split(',');
            result.push([parseInt(p1Str), parseInt(p2Str)]);
        }
    }

    result.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    return result;
};