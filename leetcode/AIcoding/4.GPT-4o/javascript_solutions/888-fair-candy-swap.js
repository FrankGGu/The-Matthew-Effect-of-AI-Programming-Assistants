var fairCandySwap = function(A, B) {
    const sumA = A.reduce((a, b) => a + b, 0);
    const sumB = B.reduce((a, b) => a + b, 0);
    const delta = (sumA - sumB) / 2;
    const setB = new Set(B);

    for (let x of A) {
        if (setB.has(x - delta)) {
            return [x, x - delta];
        }
    }
};