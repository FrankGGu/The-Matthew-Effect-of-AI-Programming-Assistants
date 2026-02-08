var removeAlmostEqualCharacters = function(s) {
    let count = 0;
    for (let i = 0; i < s.length - 1; i++) {
        if (Math.abs(s.charCodeAt(i) - s.charCodeAt(i + 1)) <= 1) {
            count++;
            i++;
        }
    }
    return count;
};