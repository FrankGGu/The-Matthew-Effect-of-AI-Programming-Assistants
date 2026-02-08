var expressiveWords = function(s, words) {
    let count = 0;

    function isStretchy(word, s) {
        let i = 0;
        let j = 0;

        while (i < word.length && j < s.length) {
            if (word[i] !== s[j]) {
                return false;
            }

            let wordChar = word[i];
            let sChar = s[j];

            let wordCount = 0;
            while (i < word.length && word[i] === wordChar) {
                wordCount++;
                i++;
            }

            let sCount = 0;
            while (j < s.length && s[j] === sChar) {
                sCount++;
                j++;
            }

            if (wordCount > sCount) {
                return false;
            }

            if (wordCount !== sCount && sCount < 3) {
                return false;
            }
        }

        return i === word.length && j === s.length;
    }

    for (let word of words) {
        if (isStretchy(word, s)) {
            count++;
        }
    }

    return count;
};