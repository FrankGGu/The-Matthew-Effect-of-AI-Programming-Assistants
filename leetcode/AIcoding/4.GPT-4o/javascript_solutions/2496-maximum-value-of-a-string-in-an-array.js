var maximumValue = function(strs) {
    let maxVal = 0;
    for (const str of strs) {
        const value = isNaN(str) ? str.length : Number(str);
        maxVal = Math.max(maxVal, value);
    }
    return maxVal;
};