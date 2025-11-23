var countPalindromicSubsequences = function(s) {
    let uniquePalindromes = 0;

    for (let i = 0; i < 26; i++) {
        const charCode = 'a'.charCodeAt(0) + i;
        const char = String.fromCharCode(charCode);

        const firstIdx = s.indexOf(char);
        const lastIdx = s.lastIndexOf(char);

        if (firstIdx !== -1 && firstIdx < lastIdx) {
            const middleChars = new Set();
            for (let j = firstIdx + 1; j < lastIdx; j++) {
                middleChars.add(s[j]);
            }
            uniquePalindromes += middleChars.size;
        }
    }

    return uniquePalindromes;
};