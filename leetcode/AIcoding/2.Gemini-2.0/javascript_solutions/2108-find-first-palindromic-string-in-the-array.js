var firstPalindrome = function(words) {
    for (let i = 0; i < words.length; i++) {
        let word = words[i];
        let reversedWord = word.split("").reverse().join("");
        if (word === reversedWord) {
            return word;
        }
    }
    return "";
};