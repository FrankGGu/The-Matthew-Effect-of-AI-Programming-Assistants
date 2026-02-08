var rearrangeCharacters = function(s, target) {
    const sCount = {};
    const targetCount = {};

    for (const char of s) {
        sCount[char] = (sCount[char] || 0) + 1;
    }

    for (const char of target) {
        targetCount[char] = (targetCount[char] || 0) + 1;
    }

    let maxCount = Infinity;

    for (const char of Object.keys(targetCount)) {
        if (!sCount[char]) return 0;
        maxCount = Math.min(maxCount, Math.floor(sCount[char] / targetCount[char]));
    }

    return maxCount;
};