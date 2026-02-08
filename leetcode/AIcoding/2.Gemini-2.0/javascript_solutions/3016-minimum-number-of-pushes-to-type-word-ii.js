var minimumPushes = function(word) {
    const freq = new Array(26).fill(0);
    for (const char of word) {
        freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    freq.sort((a, b) => b - a);

    let pushes = 0;
    for (let i = 0; i < 26; i++) {
        if (i < 8) {
            pushes += freq[i];
        } else if (i < 16) {
            pushes += 2 * freq[i];
        } else if (i < 24) {
            pushes += 3 * freq[i];
        } else {
            pushes += 4 * freq[i];
        }
    }

    return pushes;
};