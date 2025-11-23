var minimumTimeToInitialState = function(word, k) {
    const n = word.length;
    for (let t = 1; t * k < n; t++) {
        let match = true;
        for (let i = t * k; i < n; i++) {
            if (word[i] !== word[i - t * k]) {
                match = false;
                break;
            }
        }
        if (match) {
            return t;
        }
    }
    return Math.ceil(n / k);
};