function findRepeatedDnaSequences(s) {
    const seen = new Set();
    const repeated = new Set();

    for (let i = 0; i <= s.length - 10; i++) {
        const seq = s.substring(i, i + 10);
        if (seen.has(seq)) {
            repeated.add(seq);
        }
        seen.add(seq);
    }

    return Array.from(repeated);
}