var rearrangeCharacters = function(s, target) {
    const sCounts = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        sCounts[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    const targetCounts = new Array(26).fill(0);
    for (let i = 0; i < target.length; i++) {
        targetCounts[target.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let maxCopies = Infinity;

    for (let i = 0; i < 26; i++) {
        const targetCharCount = targetCounts[i];
        if (targetCharCount > 0) {
            const sCharCount = sCounts[i];
            if (sCharCount < targetCharCount) {
                return 0;
            }
            maxCopies = Math.min(maxCopies, Math.floor(sCharCount / targetCharCount));
        }
    }

    return maxCopies;
};