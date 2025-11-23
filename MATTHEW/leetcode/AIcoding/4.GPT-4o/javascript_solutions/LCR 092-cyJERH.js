var minDeletions = function(s) {
    const count = new Array(26).fill(0);
    for (let char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let deletions = 0;
    const seen = new Set();

    for (let freq of count) {
        while (freq > 0 && seen.has(freq)) {
            freq--;
            deletions++;
        }
        if (freq > 0) {
            seen.add(freq);
        }
    }

    return deletions;
};