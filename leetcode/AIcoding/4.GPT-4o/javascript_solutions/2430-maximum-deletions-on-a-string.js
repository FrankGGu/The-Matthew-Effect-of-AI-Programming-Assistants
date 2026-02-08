var maximumDeletions = function(s) {
    const freq = new Array(26).fill(0);
    for (let char of s) {
        freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    freq.sort((a, b) => b - a);

    let deletions = 0;
    let maxAllowed = freq[0];

    for (let i = 0; i < freq.length; i++) {
        if (freq[i] > maxAllowed) {
            deletions += freq[i] - maxAllowed;
            freq[i] = maxAllowed;
        }
        maxAllowed = Math.max(0, maxAllowed - 1);
    }

    return deletions;
};