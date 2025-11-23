var countPalindromicSubsequences = function(s) {
    const n = s.length;
    const uniquePalindromes = new Set();

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (s[i] === s[j]) {
                const char = s[i];
                for (let k = 0; k < n; k++) {
                    if (k !== i && k !== j && s[k] === char) {
                        uniquePalindromes.add(char + s[i] + char);
                    }
                }
            }
        }
    }

    return uniquePalindromes.size;
};