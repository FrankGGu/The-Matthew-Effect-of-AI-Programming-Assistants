var isPrefixString = function(s, words) {
    let prefix = '';
    for (let word of words) {
        prefix += word;
        if (prefix === s) return true;
        if (prefix.length > s.length) return false;
    }
    return prefix === s;
};