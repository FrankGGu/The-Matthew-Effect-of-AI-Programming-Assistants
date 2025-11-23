var runeReserve = function(runes) {
    if (runes.length === 0) return 0;
    runes.sort((a, b) => a - b);
    let maxLen = 1;
    let currentLen = 1;
    for (let i = 1; i < runes.length; i++) {
        if (runes[i] - runes[i - 1] <= 1) {
            currentLen++;
            maxLen = Math.max(maxLen, currentLen);
        } else {
            currentLen = 1;
        }
    }
    return maxLen;
};