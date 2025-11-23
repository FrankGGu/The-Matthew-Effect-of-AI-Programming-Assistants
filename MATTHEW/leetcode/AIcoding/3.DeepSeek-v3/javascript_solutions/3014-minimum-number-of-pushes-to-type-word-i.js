var minimumPushes = function(word) {
    const frequency = {};
    for (const char of word) {
        frequency[char] = (frequency[char] || 0) + 1;
    }
    const sortedChars = Object.keys(frequency).sort((a, b) => frequency[b] - frequency[a]);
    let totalPushes = 0;
    for (let i = 0; i < sortedChars.length; i++) {
        const pushes = Math.floor(i / 8) + 1;
        totalPushes += pushes * frequency[sortedChars[i]];
    }
    return totalPushes;
};