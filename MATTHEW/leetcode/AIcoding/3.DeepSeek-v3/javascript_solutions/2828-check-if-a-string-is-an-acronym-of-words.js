var isAcronym = function(words, s) {
    if (words.length !== s.length) return false;
    for (let i = 0; i < words.length; i++) {
        if (words[i].charAt(0) !== s.charAt(i)) {
            return false;
        }
    }
    return true;
};