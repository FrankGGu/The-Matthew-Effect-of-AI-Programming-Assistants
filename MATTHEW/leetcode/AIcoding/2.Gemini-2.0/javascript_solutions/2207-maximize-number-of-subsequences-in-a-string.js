var maximumSubsequenceCount = function(text, pattern) {
    let a = pattern[0];
    let b = pattern[1];
    let countA = 0;
    let countB = 0;
    let ans = 0;

    for (let i = 0; i < text.length; i++) {
        if (text[i] === b) {
            ans += countA;
            countB++;
        }
        if (text[i] === a) {
            countA++;
        }
    }

    return ans + Math.max(countA, countB);
};