var countAsterisks = function(s) {
    let count = 0;
    let inPair = false;
    for (let char of s) {
        if (char === '|') {
            inPair = !inPair;
        } else if (char === '*' && !inPair) {
            count++;
        }
    }
    return count;
};