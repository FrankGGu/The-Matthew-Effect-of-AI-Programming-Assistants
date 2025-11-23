var oddString = function(words) {
    const getDifferenceArray = (word) => {
        const diffs = [];
        for (let i = 1; i < word.length; i++) {
            diffs.push(word.charCodeAt(i) - word.charCodeAt(i - 1));
        }
        return diffs.join(',');
    };

    const diff0 = getDifferenceArray(words[0]);
    const diff1 = getDifferenceArray(words[1]);

    if (diff0 === diff1) {
        const commonPattern = diff0;
        for (let i = 2; i < words.length; i++) {
            if (getDifferenceArray(words[i]) !== commonPattern) {
                return words[i];
            }
        }
    } else {
        const diff2 = getDifferenceArray(words[2]);
        if (diff0 === diff2) {
            return words[1];
        } else {
            return words[0];
        }
    }
};