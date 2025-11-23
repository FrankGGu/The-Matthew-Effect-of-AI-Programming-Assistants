var rearrangeCharacters = function(s, target) {
    const sCount = {};
    const targetCount = {};

    for (const char of s) {
        sCount[char] = (sCount[char] || 0) + 1;
    }

    for (const char of target) {
        targetCount[char] = (targetCount[char] || 0) + 1;
    }

    let count = Infinity;
    for (const char in targetCount) {
        if (!sCount[char]) {
            return 0;
        }
        count = Math.min(count, Math.floor((sCount[char] || 0) / targetCount[char]));
    }

    return count;
};