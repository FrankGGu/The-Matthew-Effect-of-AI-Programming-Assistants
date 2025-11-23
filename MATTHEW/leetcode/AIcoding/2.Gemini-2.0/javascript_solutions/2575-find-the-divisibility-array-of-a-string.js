var divisibilityArray = function(word, m) {
    const n = word.length;
    const result = new Array(n).fill(0);
    let remainder = 0n;

    for (let i = 0; i < n; i++) {
        remainder = (remainder * 10n + BigInt(word[i])) % BigInt(m);
        if (remainder === 0n) {
            result[i] = 1;
        }
    }

    return result;
};