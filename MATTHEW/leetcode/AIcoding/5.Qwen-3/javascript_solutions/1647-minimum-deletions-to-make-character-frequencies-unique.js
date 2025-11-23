function minDeletions(s) {
    const freq = new Array(26).fill(0);
    for (const c of s) {
        freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const usedFreq = new Set();
    let deletions = 0;

    for (let i = 0; i < 26; i++) {
        while (freq[i] > 0 && usedFreq.has(freq[i])) {
            freq[i]--;
            deletions++;
        }
        if (freq[i] > 0) {
            usedFreq.add(freq[i]);
        }
    }

    return deletions;
}