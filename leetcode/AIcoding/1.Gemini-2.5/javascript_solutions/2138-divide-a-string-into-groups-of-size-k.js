var divideString = function(s, k, fill) {
    const result = [];
    let i = 0;
    while (i < s.length) {
        let currentGroup = s.substring(i, i + k);
        if (currentGroup.length < k) {
            const charsToFill = k - currentGroup.length;
            currentGroup += fill.repeat(charsToFill);
        }
        result.push(currentGroup);
        i += k;
    }
    return result;
};