function minDeletions(s, k) {
    const freq = new Array(26).fill(0);
    for (const c of s) {
        freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let deletions = 0;
    for (let i = 0; i < 26; i++) {
        while (freq[i] > k && freq[i] > 0) {
            freq[i]--;
            deletions++;
        }
    }

    return deletions;
}