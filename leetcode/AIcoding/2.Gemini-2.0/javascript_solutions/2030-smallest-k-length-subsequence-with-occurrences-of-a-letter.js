var smallestSubsequence = function(s, k, letter, repetition) {
    const n = s.length;
    let remainingLetters = 0;
    for (let char of s) {
        if (char === letter) {
            remainingLetters++;
        }
    }

    let result = "";
    let letterCount = 0;

    for (let i = 0; i < n; i++) {
        while (
            result.length > 0 &&
            result[result.length - 1] > s[i] &&
            n - i + result.length > k &&
            (result[result.length - 1] !== letter ||
                remainingLetters + letterCount > repetition)
        ) {
            if (result[result.length - 1] === letter) {
                letterCount--;
            }
            result = result.slice(0, -1);
        }

        if (result.length < k) {
            if (s[i] === letter) {
                result += s[i];
                letterCount++;
                remainingLetters--;
            } else if (k - result.length > repetition - letterCount) {
                result += s[i];
            } else {
                remainingLetters--;
            }
        } else {
            remainingLetters--;
        }
    }

    return result;
};