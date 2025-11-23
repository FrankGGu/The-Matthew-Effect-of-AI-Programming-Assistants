var minOperationsToMakeWordKPeriodic = function(word, k) {
    const n = word.length;
    const periodLength = Math.min(k, n);
    let count = 0;

    for (let i = periodLength; i < n; ++i) {
        if (word[i] !== word[i % periodLength]) {
            count++;
        }
    }

    return count;
};