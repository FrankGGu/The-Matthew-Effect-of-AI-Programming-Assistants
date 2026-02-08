var countAsterisks = function(s) {
    let count = 0;
    let inPair = false;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '|') {
            inPair = !inPair;
        } else if (s[i] === '*' && !inPair) {
            count++;
        }
    }
    return count;
};