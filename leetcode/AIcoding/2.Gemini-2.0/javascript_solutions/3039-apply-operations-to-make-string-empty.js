var lastNonEmptyString = function(s) {
    const counts = new Array(26).fill(0);
    for (const char of s) {
        counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let maxCount = 0;
    for (const count of counts) {
        maxCount = Math.max(maxCount, count);
    }

    let result = "";
    for (let i = s.length - 1; i >= 0; i--) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        if (counts[charCode] === maxCount) {
            result = s[i] + result;
            counts[charCode] = -1;
        }
    }

    return result;
};