var countVowelSubstrings = function(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;

    for (let i = 0; i < s.length; i++) {
        if (!vowels.has(s[i])) continue;
        let uniqueVowels = new Set();
        for (let j = i; j < s.length; j++) {
            if (!vowels.has(s[j])) break;
            uniqueVowels.add(s[j]);
            if (uniqueVowels.size === 5) count++;
        }
    }

    return count;
};