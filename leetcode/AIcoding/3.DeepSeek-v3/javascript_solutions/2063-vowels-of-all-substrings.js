const countVowels = function(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let total = 0;
    const n = s.length;
    for (let i = 0; i < n; i++) {
        if (vowels.has(s[i])) {
            total += (i + 1) * (n - i);
        }
    }
    return total;
};