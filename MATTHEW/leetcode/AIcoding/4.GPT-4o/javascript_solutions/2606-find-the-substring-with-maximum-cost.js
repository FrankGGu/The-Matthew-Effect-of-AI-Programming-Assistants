var maximumCostSubstring = function(s, chars, vals) {
    const charToValue = {};
    for (let i = 0; i < chars.length; i++) {
        charToValue[chars[i]] = vals[i];
    }

    let maxCost = 0, currentCost = 0;

    for (let char of s) {
        currentCost += charToValue[char] || -1;
        if (currentCost < 0) {
            currentCost = 0;
        }
        maxCost = Math.max(maxCost, currentCost);
    }

    return maxCost;
};