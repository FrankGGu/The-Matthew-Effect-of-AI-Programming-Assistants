var lastNonEmptyString = function(s) {
    const freq = new Map();
    const lastOccurrence = new Map();

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        freq.set(char, (freq.get(char) || 0) + 1);
        lastOccurrence.set(char, i);
    }

    const maxFreq = Math.max(...freq.values());
    const charsWithMaxFreq = [];

    for (const [char, count] of freq) {
        if (count === maxFreq) {
            charsWithMaxFreq.push(char);
        }
    }

    const lastIndices = charsWithMaxFreq.map(char => lastOccurrence.get(char));
    lastIndices.sort((a, b) => a - b);

    let result = [];
    for (const index of lastIndices) {
        result.push(s[index]);
    }

    return result.join('');
};