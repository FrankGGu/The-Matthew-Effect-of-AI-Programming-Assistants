var countVowelSubstrings = function(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        const seen = new Set();
        for (let j = i; j < s.length; j++) {
            if (!vowels.has(s[j])) break;
            seen.add(s[j]);
            if (seen.size === 5) count++;
        }
    }
    return count;
};