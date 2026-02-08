var countSpecialCharacters = function(word) {
    let count = 0;
    const n = word.length;
    for (let i = 0; i < n; i++) {
        if (!((word[i] >= 'a' && word[i] <= 'z') || (word[i] >= 'A' && word[i] <= 'Z') || (word[i] >= '0' && word[i] <= '9'))) {
            count++;
        }
    }
    return count;
};