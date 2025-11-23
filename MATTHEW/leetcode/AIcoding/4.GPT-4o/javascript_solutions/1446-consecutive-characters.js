var consecutiveCharacters = function(s) {
    let maxCount = 1;
    let currentCount = 1;

    for (let i = 1; i < s.length; i++) {
        if (s[i] === s[i - 1]) {
            currentCount++;
        } else {
            maxCount = Math.max(maxCount, currentCount);
            currentCount = 1;
        }
    }

    return Math.max(maxCount, currentCount);
};