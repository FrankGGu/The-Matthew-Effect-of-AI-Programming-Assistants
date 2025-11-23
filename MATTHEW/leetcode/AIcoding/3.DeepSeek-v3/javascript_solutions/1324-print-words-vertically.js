var printVertically = function(s) {
    const words = s.split(' ');
    let maxLen = 0;
    for (const word of words) {
        maxLen = Math.max(maxLen, word.length);
    }
    const result = [];
    for (let i = 0; i < maxLen; i++) {
        let column = '';
        for (const word of words) {
            column += i < word.length ? word[i] : ' ';
        }
        column = column.replace(/\s+$/, '');
        result.push(column);
    }
    return result;
};