var findRepeatedDnaSequences = function(s) {
    const seen = new Set();
    const repeated = new Set();
    for (let i = 0; i + 9 < s.length; i++) {
        const sequence = s.substring(i, i + 10);
        if (seen.has(sequence)) {
            repeated.add(sequence);
        } else {
            seen.add(sequence);
        }
    }
    return Array.from(repeated);
};