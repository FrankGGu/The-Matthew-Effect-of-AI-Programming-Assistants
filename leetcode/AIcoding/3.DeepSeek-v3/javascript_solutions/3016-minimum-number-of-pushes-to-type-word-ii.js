var minimumPushes = function(word) {
    const freq = {};
    for (const char of word) {
        freq[char] = (freq[char] || 0) + 1;
    }
    const sortedChars = Object.keys(freq).sort((a, b) => freq[b] - freq[a]);
    let totalPushes = 0;
    for (let i = 0; i < sortedChars.length; i++) {
        const pushes = Math.floor(i / 8) + 1;
        totalPushes += pushes * freq[sortedChars[i]];
    }
    return totalPushes;
};