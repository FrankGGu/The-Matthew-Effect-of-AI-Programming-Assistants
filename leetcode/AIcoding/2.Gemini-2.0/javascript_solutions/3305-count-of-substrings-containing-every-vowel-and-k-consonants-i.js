var countSubstrings = function(s, k) {
    let n = s.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        let vowels = new Set();
        let consonants = 0;
        for (let j = i; j < n; j++) {
            if ('aeiou'.includes(s[j])) {
                vowels.add(s[j]);
            } else {
                consonants++;
            }
            if (vowels.size === 5 && consonants >= k) {
                count++;
            }
        }
    }
    return count;
};