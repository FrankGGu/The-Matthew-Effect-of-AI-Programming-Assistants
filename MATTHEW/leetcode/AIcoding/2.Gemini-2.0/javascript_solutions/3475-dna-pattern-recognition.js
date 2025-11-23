var findRepeatedDnaSequences = function(s, k) {
    const seen = new Set();
    const repeated = new Set();
    for (let i = 0; i <= s.length - k; i++) {
        const sequence = s.substring(i, i + k);
        if (seen.has(sequence)) {
            repeated.add(sequence);
        } else {
            seen.add(sequence);
        }
    }
    return Array.from(repeated);
};