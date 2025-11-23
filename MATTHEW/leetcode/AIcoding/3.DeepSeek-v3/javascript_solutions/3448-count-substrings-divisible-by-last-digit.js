var countDivisibleSubstrings = function(word) {
    const prefix = new Array(word.length + 1).fill(0);
    for (let i = 0; i < word.length; i++) {
        prefix[i + 1] = prefix[i] + (word.charCodeAt(i) - 'a'.charCodeAt(0) + 1);
    }

    let count = 0;
    for (let i = 0; i < word.length; i++) {
        for (let j = i + 1; j <= word.length; j++) {
            const sum = prefix[j] - prefix[i];
            const len = j - i;
            const lastDigit = word.charCodeAt(j - 1) - 'a'.charCodeAt(0) + 1;
            if (lastDigit !== 0 && sum % lastDigit === 0) {
                count++;
            }
        }
    }
    return count;
};