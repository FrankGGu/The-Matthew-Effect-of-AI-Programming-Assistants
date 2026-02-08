function countVowels(s) {
    const n = s.length;
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let totalCount = 0;

    for (let i = 0; i < n; i++) {
        if (vowels.has(s[i])) {
            totalCount += (i + 1) * (n - i);
        }
    }

    return totalCount;
}