var maximumValue = function(strs) {
    let maxValue = 0;

    for (let i = 0; i < strs.length; i++) {
        const s = strs[i];
        let currentValue;

        // Check if the string contains only digits
        if (/^\d+$/.test(s)) {
            currentValue = parseInt(s);
        } else {
            currentValue = s.length;
        }

        maxValue = Math.max(maxValue, currentValue);
    }

    return maxValue;
};