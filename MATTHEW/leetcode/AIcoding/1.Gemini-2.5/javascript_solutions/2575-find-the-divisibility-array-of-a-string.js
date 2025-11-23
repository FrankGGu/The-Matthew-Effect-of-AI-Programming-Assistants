var divisibilityArray = function(word, m) {
    const n = word.length;
    const div = new Array(n);
    let currentRemainder = 0;

    for (let i = 0; i < n; i++) {
        const digit = parseInt(word[i]);
        currentRemainder = (currentRemainder * 10 + digit) % m;
        if (currentRemainder === 0) {
            div[i] = 1;
        } else {
            div[i] = 0;
        }
    }

    return div;
};