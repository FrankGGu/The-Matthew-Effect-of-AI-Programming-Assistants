var printVertically = function(s) {
    const words = s.split(' ');
    let maxLen = 0;
    for (const word of words) {
        maxLen = Math.max(maxLen, word.length);
    }

    const result = [];
    for (let i = 0; i < maxLen; i++) {
        let str = '';
        for (const word of words) {
            if (i < word.length) {
                str += word[i];
            } else {
                str += ' ';
            }
        }
        result.push(str.trimEnd());
    }

    return result;
};