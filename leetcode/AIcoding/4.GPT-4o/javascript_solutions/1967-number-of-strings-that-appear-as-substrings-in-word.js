var numOfStrings = function(strings, word) {
    let count = 0;
    for (let str of strings) {
        if (word.includes(str)) {
            count++;
        }
    }
    return count;
};