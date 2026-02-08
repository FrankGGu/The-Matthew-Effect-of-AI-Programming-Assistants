var prefixCount = function(words, pref) {
    let count = 0;
    const len = pref.length;
    for (const word of words) {
        if (word.length >= len && word.substring(0, len) === pref) {
            count++;
        }
    }
    return count;
};