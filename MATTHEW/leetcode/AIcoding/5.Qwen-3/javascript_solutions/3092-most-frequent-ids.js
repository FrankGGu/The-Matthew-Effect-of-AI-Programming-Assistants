function mostFrequentIDs(arr) {
    const freq = {};
    let maxFreq = 0;
    const result = [];

    for (let i = 0; i < arr.length; i++) {
        const id = arr[i];
        freq[id] = (freq[id] || 0) + 1;
        if (freq[id] > maxFreq) {
            maxFreq = freq[id];
        }
        result.push(maxFreq);
    }

    return result;
}