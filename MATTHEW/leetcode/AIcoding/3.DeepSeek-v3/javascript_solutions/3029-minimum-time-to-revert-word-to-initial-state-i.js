var minimumTimeToInitialState = function(word, k) {
    let n = word.length;
    let res = 1;
    for (let i = k; i < n; i += k, res++) {
        let match = true;
        for (let j = i; j < n; j++) {
            if (word[j] !== word[j - i]) {
                match = false;
                break;
            }
        }
        if (match) return res;
    }
    return res;
};