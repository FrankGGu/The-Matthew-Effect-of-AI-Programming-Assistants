var makeSmallestPalindrome = function(s) {
    const n = s.length;
    const chars = s.split('');

    for (let i = 0; i < Math.floor(n / 2); i++) {
        const leftChar = chars[i];
        const rightChar = chars[n - 1 - i];

        if (leftChar !== rightChar) {
            const minChar = (leftChar < rightChar) ? leftChar : rightChar;
            chars[i] = minChar;
            chars[n - 1 - i] = minChar;
        }
    }

    return chars.join('');
};