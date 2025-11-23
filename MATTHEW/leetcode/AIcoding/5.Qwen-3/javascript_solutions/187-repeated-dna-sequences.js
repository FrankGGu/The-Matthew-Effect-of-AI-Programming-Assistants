function findRepeatedDnaSequences(s) {
    const seen = new Set();
    const result = new Set();
    const n = s.length;
    for (let i = 0; i <= n - 10; i++) {
        const seq = s.substring(i, i + 10);
        if (seen.has(seq)) {
            result.add(seq);
        } else {
            seen.add(seq);
        }
    }
    return Array.from(result);
}