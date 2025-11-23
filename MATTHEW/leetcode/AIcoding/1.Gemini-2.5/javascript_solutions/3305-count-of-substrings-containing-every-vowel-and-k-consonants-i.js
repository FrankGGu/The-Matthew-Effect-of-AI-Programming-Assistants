var countSubstrings = function(s, k) {
    let n = s.length;
    let totalCount = 0;

    const isVowel = (char) => {
        return char === 'a' || char === 'e' || char === 'i' || char === 'o' || char === 'u';
    };

    for (let i = 0; i < n; i++) {
        let vowelSet = new Set();
        let consonantCount = 0;

        for (let j = i; j < n; j++) {
            let char = s[j];
            if (isVowel(char)) {
                vowelSet.add(char);
            } else {
                consonantCount++;
            }

            if (vowelSet.size === 5 && consonantCount === k) {
                totalCount++;
            }
        }
    }

    return totalCount;
};