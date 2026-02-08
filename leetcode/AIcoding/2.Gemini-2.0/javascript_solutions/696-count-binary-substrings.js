var countBinarySubstrings = function(s) {
    let prevRunLength = 0;
    let currRunLength = 1;
    let result = 0;

    for (let i = 1; i < s.length; i++) {
        if (s[i] === s[i - 1]) {
            currRunLength++;
        } else {
            result += Math.min(prevRunLength, currRunLength);
            prevRunLength = currRunLength;
            currRunLength = 1;
        }
    }

    result += Math.min(prevRunLength, currRunLength);
    return result;
};