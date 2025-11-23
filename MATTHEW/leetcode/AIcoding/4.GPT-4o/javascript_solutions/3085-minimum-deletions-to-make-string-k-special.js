function minimumDeletions(s, k) {
    const freq = new Array(26).fill(0);
    for (const char of s) {
        freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    freq.sort((a, b) => b - a);

    let deletions = 0;
    for (let i = k; i < 26; i++) {
        deletions += freq[i];
    }

    return deletions;
}