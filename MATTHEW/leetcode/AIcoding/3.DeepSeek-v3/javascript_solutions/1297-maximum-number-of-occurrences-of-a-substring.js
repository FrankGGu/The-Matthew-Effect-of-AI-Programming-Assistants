var maxFreq = function(s, maxLetters, minSize, maxSize) {
    const substrCount = new Map();
    let max = 0;

    for (let i = 0; i <= s.length - minSize; i++) {
        const substr = s.substr(i, minSize);
        const uniqueChars = new Set(substr);

        if (uniqueChars.size <= maxLetters) {
            const count = (substrCount.get(substr) || 0) + 1;
            substrCount.set(substr, count);
            max = Math.max(max, count);
        }
    }

    return max;
};