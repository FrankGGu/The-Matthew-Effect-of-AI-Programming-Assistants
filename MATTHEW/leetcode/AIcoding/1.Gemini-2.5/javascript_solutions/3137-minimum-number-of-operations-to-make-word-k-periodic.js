var minimumOperationsToMakeKPeriodic = function(word, k) {
    const n = word.length;
    const blockCounts = new Map();

    for (let i = 0; i < n; i += k) {
        const sub = word.substring(i, i + k);
        blockCounts.set(sub, (blockCounts.get(sub) || 0) + 1);
    }

    let maxFreq = 0;
    for (const count of blockCounts.values()) {
        if (count > maxFreq) {
            maxFreq = count;
        }
    }

    const numBlocks = n / k;
    const operations = (numBlocks - maxFreq) * k;

    return operations;
};