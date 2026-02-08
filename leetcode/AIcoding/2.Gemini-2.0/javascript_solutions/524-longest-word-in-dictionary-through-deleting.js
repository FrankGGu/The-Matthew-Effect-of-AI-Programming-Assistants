var findLongestWord = function(s, dictionary) {
    let longest = "";
    for (let word of dictionary) {
        let i = 0, j = 0;
        while (i < s.length && j < word.length) {
            if (s[i] === word[j]) {
                j++;
            }
            i++;
        }
        if (j === word.length) {
            if (word.length > longest.length || (word.length === longest.length && word < longest)) {
                longest = word;
            }
        }
    }
    return longest;
};