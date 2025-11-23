var firstLetterToAppearTwice = function(s) {
    const seen = new Set();

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (seen.has(char)) {
            return char;
        }
        seen.add(char);
    }
};