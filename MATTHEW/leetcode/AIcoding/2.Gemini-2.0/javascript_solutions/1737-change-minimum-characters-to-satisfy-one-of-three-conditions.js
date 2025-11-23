var minCharacters = function(a, b) {
    const n = a.length;
    const m = b.length;
    let countA = new Array(26).fill(0);
    let countB = new Array(26).fill(0);

    for (let char of a) {
        countA[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }
    for (let char of b) {
        countB[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let ans = n + m;

    for (let i = 0; i < 26; i++) {
        ans = Math.min(ans, n - countA[i] + m - countB[i]);
    }

    for (let i = 0; i < 25; i++) {
        let sumA = 0;
        let sumB = 0;
        for (let j = 0; j <= i; j++) {
            sumA += countA[j];
            sumB += countB[j];
        }
        ans = Math.min(ans, n - sumA + sumB);
        ans = Math.min(ans, m - sumB + sumA);
    }

    return ans;
};