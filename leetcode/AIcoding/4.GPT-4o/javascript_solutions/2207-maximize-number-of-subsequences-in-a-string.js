var maximumSubsequenceCount = function(text, pattern) {
    let count = 0;
    let countP1 = 0;
    let countP2 = 0;
    const p1 = pattern[0];
    const p2 = pattern[1];

    for (const char of text) {
        if (char === p1) countP1++;
        if (char === p2) countP2++;
    }

    let maxCount = countP2;

    for (let i = 0; i < text.length; i++) {
        if (text[i] === p1) {
            count++;
        }
        if (text[i] === p2) {
            countP2--;
        }
        maxCount = Math.max(maxCount, count + countP2);
        if (text[i] === p2) {
            countP2++;
        }
    }

    return maxCount + (countP1 > count ? 1 : 0);
};