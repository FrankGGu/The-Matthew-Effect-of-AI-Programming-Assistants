var uniqueLetterString = function(s) {
    const n = s.length;
    const lastPos = new Array(26).fill(-1);
    const contribution = new Array(26).fill(0);
    let res = 0;
    let total = 0;

    for (let i = 0; i < n; i++) {
        const c = s.charCodeAt(i) - 'A'.charCodeAt(0);
        total -= contribution[c];
        contribution[c] = i - lastPos[c];
        total += contribution[c];
        res += total;
        lastPos[c] = i;
    }

    return res;
};