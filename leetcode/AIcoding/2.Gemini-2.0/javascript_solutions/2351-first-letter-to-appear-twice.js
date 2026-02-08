var repeatedCharacter = function(s) {
    const seen = new Set();
    for (let i = 0; i < s.length; i++) {
        if (seen.has(s[i])) {
            return s[i];
        }
        seen.add(s[i]);
    }
};