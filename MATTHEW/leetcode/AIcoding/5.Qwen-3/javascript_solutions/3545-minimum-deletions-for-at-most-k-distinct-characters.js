function minDeletions(s, k) {
    const freq = new Array(26).fill(0);
    for (const c of s) {
        freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    freq.sort((a, b) => b - a);

    let deletions = 0;
    for (let i = k; i < 26; i++) {
        if (freq[i] === 0) continue;
        let current = freq[i];
        while (current > 0 && freq[k - 1] >= current) {
            current--;
            deletions++;
        }
        if (current > 0) {
            freq[k - 1] = current;
        }
    }

    return deletions;
}