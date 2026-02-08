var findLongestWord = function(s, dictionary) {
    let longestWord = "";

    const isSubsequence = (str, sub) => {
        let i = 0;
        let j = 0;
        while (i < str.length && j < sub.length) {
            if (str[i] === sub[j]) {
                j++;
            }
            i++;
        }
        return j === sub.length;
    };

    for (const word of dictionary) {
        if (isSubsequence(s, word)) {
            if (word.length > longestWord.length) {
                longestWord = word;
            } else if (word.length === longestWord.length) {
                if (word < longestWord) {
                    longestWord = word;
                }
            }
        }
    }

    return longestWord;
};