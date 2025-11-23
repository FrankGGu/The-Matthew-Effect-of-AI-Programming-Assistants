var removeAlmostEqualCharacters = function(word) {
    let count = 0;
    for (let i = 1; i < word.length; i++) {
        const prev = word[i - 1];
        const curr = word[i];
        if (Math.abs(prev.charCodeAt() - curr.charCodeAt()) <= 1) {
            count++;
            i++; // skip next character
        }
    }
    return count;
};