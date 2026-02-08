var wordCount = function(startWords, targetWords) {
    const startSet = new Set();
    for (const word of startWords) {
        const sortedWord = [...word].sort().join('');
        startSet.add(sortedWord);
    }

    let count = 0;
    for (const target of targetWords) {
        const sortedTarget = [...target].sort().join('');
        for (let i = 0; i < sortedTarget.length; i++) {
            const sub = sortedTarget.substring(0, i) + sortedTarget.substring(i + 1);
            if (startSet.has(sub)) {
                count++;
                break;
            }
        }
    }

    return count;
};