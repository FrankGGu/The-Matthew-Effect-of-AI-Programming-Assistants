var longestWord = function(words) {
    words.sort();
    let set = new Set(words);
    let result = '';

    for (let word of words) {
        let isValid = true;
        for (let i = 1; i < word.length; i++) {
            if (!set.has(word.substring(0, i))) {
                isValid = false;
                break;
            }
        }
        if (isValid && word.length > result.length) {
            result = word;
        } else if (isValid && word.length === result.length && word < result) {
            result = word;
        }
    }

    return result;
};