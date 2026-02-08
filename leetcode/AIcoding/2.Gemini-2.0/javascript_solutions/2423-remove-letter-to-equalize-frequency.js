var equalFrequency = function(word) {
    const n = word.length;
    for (let i = 0; i < n; i++) {
        const newWord = word.slice(0, i) + word.slice(i + 1);
        if (newWord.length === 0) return true;
        const freq = {};
        for (const char of newWord) {
            freq[char] = (freq[char] || 0) + 1;
        }
        const counts = Object.values(freq);
        if (new Set(counts).size === 1) {
            return true;
        }
    }
    return false;
};