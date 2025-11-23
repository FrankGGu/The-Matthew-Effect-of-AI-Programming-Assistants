var minimumOperationsToMakeKPeriodic = function(word, k) {
    const n = word.length;
    const freq = new Map();
    let maxFreq = 0;

    for (let i = 0; i < n; i += k) {
        const segment = word.substr(i, k);
        freq.set(segment, (freq.get(segment) || 0) + 1);
        maxFreq = Math.max(maxFreq, freq.get(segment));
    }

    return (n / k) - maxFreq;
};