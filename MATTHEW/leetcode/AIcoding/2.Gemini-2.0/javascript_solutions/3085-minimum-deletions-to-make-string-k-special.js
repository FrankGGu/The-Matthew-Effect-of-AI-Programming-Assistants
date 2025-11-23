var minDeletions = function(s, k) {
    const n = s.length;
    const freq = new Array(26).fill(0);
    for (const char of s) {
        freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }
    freq.sort((a, b) => b - a);

    let deletions = 0;
    for (let i = 1; i < 26; i++) {
        while (freq[i] >= freq[i - 1] && freq[i] > 0) {
            freq[i]--;
            deletions++;
        }
    }

    return deletions;
};