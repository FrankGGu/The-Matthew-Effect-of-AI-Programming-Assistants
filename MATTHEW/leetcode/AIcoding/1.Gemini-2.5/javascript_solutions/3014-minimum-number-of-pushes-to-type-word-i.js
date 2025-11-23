var minimumPushes = function(word) {
    const distinctChars = new Set(word);
    return distinctChars.size;
};