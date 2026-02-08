var minCharacters = function(a, b) {
    const countA = new Array(26).fill(0);
    const countB = new Array(26).fill(0);

    for (const c of a) countA[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    for (const c of b) countB[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;

    let res = Infinity;
    let sumA = 0, sumB = 0;

    for (let i = 0; i < 25; i++) {
        sumA += countA[i];
        sumB += countB[i];
        res = Math.min(res, sumA + b.length - sumB);
        res = Math.min(res, sumB + a.length - sumA);
    }

    for (let i = 0; i < 26; i++) {
        res = Math.min(res, a.length + b.length - countA[i] - countB[i]);
    }

    return res;
};