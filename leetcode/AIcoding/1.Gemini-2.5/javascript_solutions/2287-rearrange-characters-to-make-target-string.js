var rearrangeCharacters = function(s, target) {
    const sFreq = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        sFreq[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    const targetFreq = new Array(26).fill(0);
    for (let i = 0; i < target.length; i++) {
        targetFreq[target.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let minCopies = Infinity;

    for (let i = 0; i < 26; i++) {
        if (targetFreq[i] > 0) {
            const sCount = sFreq[i];
            const targetCount = targetFreq[i];
            minCopies = Math.min(minCopies, Math.floor(sCount / targetCount));
        }
    }

    return minCopies;
};