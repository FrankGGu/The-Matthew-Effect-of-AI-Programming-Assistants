function countBeautifulSubstrings(s) {
    let count = 0;
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    for (let i = 0; i < s.length; i++) {
        let vowelCount = 0;
        for (let j = i; j < s.length; j++) {
            if (vowels.has(s[j])) {
                vowelCount++;
            }
            if ((j - i + 1) % 2 === 0 && vowelCount === (j - i + 1) / 2) {
                count++;
            }
        }
    }
    return count;
}