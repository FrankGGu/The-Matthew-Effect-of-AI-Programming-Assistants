var sortString = function(s) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }
    const sortedChars = Object.keys(freq).sort();
    let result = [];
    let remaining = s.length;

    while (remaining > 0) {
        for (const char of sortedChars) {
            if (freq[char] > 0) {
                result.push(char);
                freq[char]--;
                remaining--;
            }
        }
        for (let i = sortedChars.length - 1; i >= 0; i--) {
            const char = sortedChars[i];
            if (freq[char] > 0) {
                result.push(char);
                freq[char]--;
                remaining--;
            }
        }
    }
    return result.join('');
};