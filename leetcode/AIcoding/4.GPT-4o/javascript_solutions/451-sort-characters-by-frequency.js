var frequencySort = function(s) {
    const freqMap = {};
    for (const char of s) {
        freqMap[char] = (freqMap[char] || 0) + 1;
    }
    return Object.keys(freqMap).sort((a, b) => freqMap[b] - freqMap[a]).map(char => char.repeat(freqMap[char])).join('');
};