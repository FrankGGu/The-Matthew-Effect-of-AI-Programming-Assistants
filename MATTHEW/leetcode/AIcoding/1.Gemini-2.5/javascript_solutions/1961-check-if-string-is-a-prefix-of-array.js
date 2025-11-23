var isPrefixString = function(s, words) {
    let currentPrefix = "";
    for (let i = 0; i < words.length; i++) {
        currentPrefix += words[i];
        if (currentPrefix === s) {
            return true;
        }
        if (currentPrefix.length >= s.length) {
            return false;
        }
    }
    return false;
};