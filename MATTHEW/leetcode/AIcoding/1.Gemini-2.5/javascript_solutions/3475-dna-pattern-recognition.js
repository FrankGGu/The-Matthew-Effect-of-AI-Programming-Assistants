var findRepeatedDnaSequences = function(s) {
    const seen = new Set();
    const result = new Set();
    const L = 10;

    if (s.length < L) {
        return [];
    }

    for (let i = 0; i <= s.length - L; i++) {
        const sequence = s.substring(i, i + L);
        if (seen.has(sequence)) {
            result.add(sequence);
        } else {
            seen.add(sequence);
        }
    }

    return Array.from(result);
};