var findLongestWord = function(s, dictionary) {
    function isSubsequence(word, s) {
        let i = 0;
        let j = 0;
        while (i < word.length && j < s.length) {
            if (word[i] === s[j]) {
                i++;
            }
            j++;
        }
        return i === word.length;
    }

    let longestWordFound = "";

    for (const word of dictionary) {
        if (isSubsequence(word, s)) {
            if (word.length > longestWordFound.length) {
                longestWordFound = word;
            } else if (word.length === longestWordFound.length) {
                if (word < longestWordFound) {
                    longestWordFound = word;
                }
            }
        }
    }

    return longestWordFound;
};