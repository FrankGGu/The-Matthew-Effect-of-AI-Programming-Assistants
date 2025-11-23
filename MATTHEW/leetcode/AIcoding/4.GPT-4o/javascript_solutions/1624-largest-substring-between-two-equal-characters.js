var maxLengthBetweenEqualCharacters = function(s) {
    const map = new Map();
    let maxLength = -1;

    for (let i = 0; i < s.length; i++) {
        if (map.has(s[i])) {
            maxLength = Math.max(maxLength, i - map.get(s[i]) - 1);
        } else {
            map.set(s[i], i);
        }
    }

    return maxLength;
};