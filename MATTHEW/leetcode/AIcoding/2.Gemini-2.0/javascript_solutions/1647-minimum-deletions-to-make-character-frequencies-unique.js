var minDeletions = function(s) {
    const freq = new Array(26).fill(0);
    for (const char of s) {
        freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    freq.sort((a, b) => b - a);

    let deletions = 0;
    let seen = new Set();

    for (let i = 0; i < 26; i++) {
        while (freq[i] > 0 && seen.has(freq[i])) {
            freq[i]--;
            deletions++;
        }
        seen.add(freq[i]);
    }

    return deletions;
};