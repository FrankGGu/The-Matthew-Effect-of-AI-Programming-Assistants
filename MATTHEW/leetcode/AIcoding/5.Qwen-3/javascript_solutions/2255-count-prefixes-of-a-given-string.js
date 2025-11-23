function countPrefixes(s, words) {
    let count = 0;
    for (let word of words) {
        if (s.startsWith(word)) {
            count++;
        }
    }
    return count;
}