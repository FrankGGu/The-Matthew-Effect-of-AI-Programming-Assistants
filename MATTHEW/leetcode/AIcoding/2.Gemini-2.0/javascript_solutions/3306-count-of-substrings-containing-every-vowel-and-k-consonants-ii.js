var countSubstrings = function(s, k) {
    let n = s.length;
    let ans = 0;

    for (let i = 0; i < n; i++) {
        let vowels = 0;
        let consonants = 0;
        let vowelSet = new Set();

        for (let j = i; j < n; j++) {
            let char = s[j];

            if (char === 'a' || char === 'e' || char === 'i' || char === 'o' || char === 'u') {
                vowelSet.add(char);
                vowels++;
            } else {
                consonants++;
            }

            if (vowelSet.size === 5 && consonants >= k) {
                ans += (n - j);
                break;
            }
        }
    }

    return ans;
};