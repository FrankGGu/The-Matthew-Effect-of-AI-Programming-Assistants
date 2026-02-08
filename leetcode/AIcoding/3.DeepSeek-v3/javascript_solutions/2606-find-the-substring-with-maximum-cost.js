var maximumCostSubstring = function(s, chars, vals) {
    const costMap = {};
    for (let i = 0; i < 26; i++) {
        const char = String.fromCharCode('a'.charCodeAt(0) + i);
        costMap[char] = i + 1;
    }
    for (let i = 0; i < chars.length; i++) {
        costMap[chars[i]] = vals[i];
    }
    let maxCost = 0;
    let currentCost = 0;
    for (const char of s) {
        currentCost += costMap[char];
        if (currentCost < 0) {
            currentCost = 0;
        }
        if (currentCost > maxCost) {
            maxCost = currentCost;
        }
    }
    return maxCost;
};