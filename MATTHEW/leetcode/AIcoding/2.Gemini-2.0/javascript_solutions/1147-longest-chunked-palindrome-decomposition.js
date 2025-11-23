var longestDecomposition = function(text) {
    let n = text.length;
    if (n === 0) return 0;

    for (let i = 0; i < Math.floor(n / 2); i++) {
        if (text.substring(0, i + 1) === text.substring(n - i - 1)) {
            return 2 + longestDecomposition(text.substring(i + 1, n - i - 1));
        }
    }

    return 1;
};