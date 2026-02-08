var oddString = function(words) {
    const diffs = [];
    for (const word of words) {
        const diff = [];
        for (let i = 1; i < word.length; i++) {
            diff.push(word.charCodeAt(i) - word.charCodeAt(i - 1));
        }
        diffs.push(diff.join(','));
    }

    const counts = {};
    for (const diff of diffs) {
        counts[diff] = (counts[diff] || 0) + 1;
    }

    let oddDiff = null;
    for (const diff in counts) {
        if (counts[diff] === 1) {
            oddDiff = diff;
            break;
        }
    }

    for (let i = 0; i < words.length; i++) {
        const diff = [];
        const word = words[i];
        for (let j = 1; j < word.length; j++) {
            diff.push(word.charCodeAt(j) - word.charCodeAt(j - 1));
        }
        if (diff.join(',') === oddDiff) {
            return word;
        }
    }
};