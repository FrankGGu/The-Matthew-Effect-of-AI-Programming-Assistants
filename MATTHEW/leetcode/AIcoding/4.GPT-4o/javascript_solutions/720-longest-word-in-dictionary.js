var longestWord = function(words) {
    let wordSet = new Set(words);
    let longest = "";

    for (let word of words) {
        if (word.length > longest.length || (word.length === longest.length && word < longest)) {
            let valid = true;
            for (let i = 1; i < word.length; i++) {
                if (!wordSet.has(word.substring(0, i))) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                longest = word;
            }
        }
    }

    return longest;
};