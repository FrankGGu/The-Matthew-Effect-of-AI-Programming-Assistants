var numOfStrings = function(patterns, word) {
    let count = 0;
    for (let i = 0; i < patterns.length; i++) {
        if (word.includes(patterns[i])) {
            count++;
        }
    }
    return count;
};