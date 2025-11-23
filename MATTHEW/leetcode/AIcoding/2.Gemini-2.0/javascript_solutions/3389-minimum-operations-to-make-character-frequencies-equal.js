var minOperations = function(s) {
    const freq = new Array(26).fill(0);
    for (const char of s) {
        freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const counts = [];
    for (let i = 0; i < 26; i++) {
        if (freq[i] > 0) {
            counts.push(freq[i]);
        }
    }

    counts.sort((a, b) => b - a);

    let operations = 0;
    let seen = new Set();

    for (let i = 0; i < counts.length; i++) {
        while (counts[i] > 0 && seen.has(counts[i])) {
            counts[i]--;
            operations++;
        }
        seen.add(counts[i]);
    }

    return operations;
};