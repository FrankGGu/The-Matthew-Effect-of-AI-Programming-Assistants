var isPrefixString = function(s, words) {
    let current = "";
    for (let word of words) {
        current += word;
        if (current === s) {
            return true;
        }
        if (current.length > s.length) {
            return false;
        }
    }
    return current === s;
};