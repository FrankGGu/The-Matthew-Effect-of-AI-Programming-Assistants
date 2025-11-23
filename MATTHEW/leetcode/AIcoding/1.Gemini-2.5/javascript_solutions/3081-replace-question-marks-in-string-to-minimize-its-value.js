var minimizeStringValue = function(s) {
    let result = [];
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '?') {
            result.push('a');
        } else {
            result.push(s[i]);
        }
    }
    return result.join('');
};