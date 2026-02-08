var greatestLetter = function(s) {
    const seen = new Set();
    for (let char of s) {
        seen.add(char);
    }
    for (let i = 25; i >= 0; i--) {
        const upper = String.fromCharCode(65 + i);
        const lower = String.fromCharCode(97 + i);
        if (seen.has(upper) && seen.has(lower)) {
            return upper;
        }
    }
    return "";
};