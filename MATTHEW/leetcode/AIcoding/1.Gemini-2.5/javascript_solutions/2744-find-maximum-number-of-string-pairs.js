var findMaximumNumberOfStringPairs = function(words) {
    let count = 0;
    const n = words.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const reversedWordI = words[i][1] + words[i][0];
            if (reversedWordI === words[j]) {
                count++;
            }
        }
    }
    return count;
};