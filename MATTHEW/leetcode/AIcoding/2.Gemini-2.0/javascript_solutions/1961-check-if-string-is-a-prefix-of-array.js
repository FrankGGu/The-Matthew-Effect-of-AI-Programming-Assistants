var isPrefixString = function(s, words) {
    let prefix = "";
    for (let i = 0; i < words.length; i++) {
        prefix += words[i];
        if (prefix === s) {
            return true;
        } else if (prefix.length > s.length) {
            return false;
        }
    }
    return false;
};