var oddString = function(words) {
    const getDiffs = (word) => {
        let diffs = [];
        for (let i = 1; i < word.length; i++) {
            diffs.push(word.charCodeAt(i) - word.charCodeAt(i - 1));
        }
        return diffs.join(',');
    };

    const diffMap = new Map();
    for (const word of words) {
        const diff = getDiffs(word);
        diffMap.set(diff, (diffMap.get(diff) || 0) + 1);
    }

    for (const word of words) {
        if (diffMap.get(getDiffs(word)) === 1) {
            return word;
        }
    }
};