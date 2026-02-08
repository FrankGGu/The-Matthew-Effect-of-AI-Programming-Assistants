var isValidAdjacentPairs = function(s) {
    for (let i = 0; i < s.length - 1; i++) {
        const a = parseInt(s[i]);
        const b = parseInt(s[i + 1]);

        if ((a + b) % 2 === 0 && a !== b) {
            return true;
        }
    }
    return false;
};