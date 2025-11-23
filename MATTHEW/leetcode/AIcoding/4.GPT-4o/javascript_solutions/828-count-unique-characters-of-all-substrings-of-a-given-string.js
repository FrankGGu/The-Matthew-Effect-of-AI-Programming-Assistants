var uniqueLetterString = function(s) {
    let total = 0;
    let lastIndex = new Array(26).fill(-1);
    let n = s.length;

    for (let i = 0; i < n; i++) {
        let idx = s.charCodeAt(i) - 'A'.charCodeAt(0);
        total += (i - lastIndex[idx]) * (n - i);
        lastIndex[idx] = i;
    }

    return total;
};