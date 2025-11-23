var equalFrequency = function(word) {
    const freq = {};
    for (const char of word) {
        freq[char] = (freq[char] || 0) + 1;
    }
    const counts = Object.values(freq);
    for (let i = 0; i < counts.length; i++) {
        const temp = [...counts];
        temp[i]--;
        if (temp[i] === 0) {
            temp.splice(i, 1);
        }
        if (new Set(temp).size === 1) {
            return true;
        }
    }
    return false;
};