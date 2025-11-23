function difference(a, b) {
    const set = new Set(b);
    return a.filter(word => set.has(word)).length;
}

function countWordsObtainedAfterAddingALetter(startWords, targetWords) {
    const wordMap = new Map();
    for (const word of startWords) {
        const sorted = word.split('').sort().join('');
        if (!wordMap.has(sorted)) {
            wordMap.set(sorted, new Set());
        }
        wordMap.get(sorted).add(word);
    }

    let count = 0;
    for (const target of targetWords) {
        const sortedTarget = target.split('').sort().join('');
        for (let i = 0; i < sortedTarget.length; i++) {
            const temp = sortedTarget.slice(0, i) + sortedTarget.slice(i + 1);
            if (wordMap.has(temp)) {
                count++;
                break;
            }
        }
    }
    return count;
}