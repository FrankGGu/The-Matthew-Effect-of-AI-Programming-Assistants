var mostFrequentIDs = function(ids) {
    const freqMap = new Map();
    for (const id of ids) {
        freqMap.set(id, (freqMap.get(id) || 0) + 1);
    }

    let maxFreq = 0;
    for (const freq of freqMap.values()) {
        maxFreq = Math.max(maxFreq, freq);
    }

    const result = [];
    for (const [id, freq] of freqMap.entries()) {
        if (freq === maxFreq) {
            result.push(id);
        }
    }

    result.sort((a, b) => a - b);
    return result;
};