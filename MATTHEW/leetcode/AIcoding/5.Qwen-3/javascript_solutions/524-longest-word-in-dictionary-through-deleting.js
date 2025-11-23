function findLongestWord(sentence, dictionary) {
    dictionary.sort((a, b) => {
        if (b.length !== a.length) {
            return b.length - a.length;
        }
        return a.localeCompare(b);
    });

    for (let word of dictionary) {
        let i = 0, j = 0;
        while (i < sentence.length && j < word.length) {
            if (sentence[i] === word[j]) {
                j++;
            }
            i++;
        }
        if (j === word.length) {
            return word;
        }
    }
    return "";
}