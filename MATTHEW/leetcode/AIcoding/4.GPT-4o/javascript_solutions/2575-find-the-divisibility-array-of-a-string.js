var divisibilityArray = function(word, m) {
    const n = word.length;
    const result = new Array(n);
    let currentNum = 0;

    for (let i = 0; i < n; i++) {
        currentNum = (currentNum * 10 + Number(word[i])) % m;
        result[i] = currentNum === 0 ? 1 : 0;
    }

    return result;
};