function shortestSubarray(s, words) {
    const wordSet = new Set(words);
    const n = s.length;
    const result = [];

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j <= n; j++) {
            const substring = s.substring(i, j);
            if (wordSet.has(substring)) {
                result.push(substring);
                break;
            }
        }
    }

    return result.sort((a, b) => a.length - b.length)[0] || "";
}