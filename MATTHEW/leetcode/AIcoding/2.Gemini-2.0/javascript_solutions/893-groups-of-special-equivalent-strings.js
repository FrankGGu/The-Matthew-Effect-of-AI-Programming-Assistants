var numSpecialEquivGroups = function(A) {
    const seen = new Set();
    for (const str of A) {
        const evenChars = [];
        const oddChars = [];
        for (let i = 0; i < str.length; i++) {
            if (i % 2 === 0) {
                evenChars.push(str[i]);
            } else {
                oddChars.push(str[i]);
            }
        }
        evenChars.sort();
        oddChars.sort();
        const key = evenChars.join('') + '|' + oddChars.join('');
        seen.add(key);
    }
    return seen.size;
};