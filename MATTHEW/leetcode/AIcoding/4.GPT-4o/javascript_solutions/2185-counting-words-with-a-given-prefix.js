function countWordsWithPrefix(words, prefix) {
    let count = 0;
    for (let word of words) {
        if (word.startsWith(prefix)) {
            count++;
        }
    }
    return count;
}