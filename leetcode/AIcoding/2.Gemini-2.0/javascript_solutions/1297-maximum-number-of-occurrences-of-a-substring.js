var maxFreq = function(s, maxLetters, minSize, maxSize) {
    const n = s.length;
    const count = new Map();
    let max = 0;

    for (let i = 0; i <= n - minSize; i++) {
        const sub = s.substring(i, i + minSize);
        const uniqueChars = new Set(sub);

        if (uniqueChars.size <= maxLetters) {
            count.set(sub, (count.get(sub) || 0) + 1);
            max = Math.max(max, count.get(sub));
        }
    }

    return max;
};