var countBeautifulSubstrings = function(s, k) {
    const vowelsSet = new Set(['a', 'e', 'i', 'o', 'u']);

    function isVowel(char) {
        return vowelsSet.has(char);
    }

    let beautifulCount = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        let currentVowels = 0;
        let currentConsonants = 0;
        for (let j = i; j < n; j++) {
            if (isVowel(s[j])) {
                currentVowels++;
            } else {
                currentConsonants++;
            }

            if (currentVowels === currentConsonants) {
                if ((currentVowels * currentConsonants) % k === 0) {
                    beautifulCount++;
                }
            }
        }
    }

    return beautifulCount;
};