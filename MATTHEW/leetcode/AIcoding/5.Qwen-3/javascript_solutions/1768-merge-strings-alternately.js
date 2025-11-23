function mergeAlternately(word1, word2) {
    let result = [];
    let i = 0;
    while (i < word1.length || i < word2.length) {
        if (i < word1.length) {
            result.push(word1[i]);
        }
        if (i < word2.length) {
            result.push(word2[i]);
        }
        i++;
    }
    return result.join('');
}