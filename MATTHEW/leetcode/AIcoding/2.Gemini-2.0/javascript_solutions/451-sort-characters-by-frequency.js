var frequencySort = function(s) {
    const freqMap = new Map();
    for (const char of s) {
        freqMap.set(char, (freqMap.get(char) || 0) + 1);
    }

    const sortedChars = Array.from(freqMap.entries()).sort(([, freqA], [, freqB]) => freqB - freqA);

    let result = "";
    for (const [char, freq] of sortedChars) {
        result += char.repeat(freq);
    }

    return result;
};