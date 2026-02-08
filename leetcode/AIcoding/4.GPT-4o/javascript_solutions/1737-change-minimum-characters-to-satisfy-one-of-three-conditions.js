var minCharacter = function(s) {
    const n = s.length;
    const count = new Array(26).fill(0);

    for (let char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let minChange = n;

    for (let i = 0; i < 26; i++) {
        const currentCharCount = count[i];
        const total = n - currentCharCount;

        const lessThan = total - (i > 0 ? count[i - 1] : 0);
        const greaterThan = total - (i < 25 ? count[i + 1] : 0);

        minChange = Math.min(minChange, lessThan + (i > 0 ? count[i - 1] : 0));
        minChange = Math.min(minChange, greaterThan + (i < 25 ? count[i + 1] : 0));
    }

    return minChange;
};