var oddString = function(words) {
    const getDifferenceArray = (word) => {
        const diff = [];
        for (let i = 1; i < word.length; i++) {
            diff.push(word.charCodeAt(i) - word.charCodeAt(i - 1));
        }
        return diff.join(',');
    };

    const diffMap = new Map();
    for (const word of words) {
        const diff = getDifferenceArray(word);
        if (diffMap.has(diff)) {
            diffMap.get(diff).count++;
            diffMap.get(diff).word = word;
        } else {
            diffMap.set(diff, { count: 1, word });
        }
    }

    for (const [diff, info] of diffMap) {
        if (info.count === 1) {
            return info.word;
        }
    }

    return "";
};