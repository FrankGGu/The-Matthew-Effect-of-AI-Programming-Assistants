var reversePrefix = function(word, ch) {
    let index = word.indexOf(ch);
    if (index === -1) {
        return word;
    }
    let prefix = word.substring(0, index + 1);
    let reversedPrefix = prefix.split("").reverse().join("");
    return reversedPrefix + word.substring(index + 1);
};