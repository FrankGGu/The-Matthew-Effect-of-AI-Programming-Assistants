var divisibilityArray = function(word, m) {
    let n = word.length;
    let div = new Array(n).fill(0);
    let remainder = 0;
    for (let i = 0; i < n; i++) {
        let digit = parseInt(word[i]);
        remainder = (remainder * 10 + digit) % m;
        if (remainder === 0) {
            div[i] = 1;
        }
    }
    return div;
};