var fairCandySwap = function(A, B) {
    let sumA = A.reduce((acc, num) => acc + num, 0);
    let sumB = B.reduce((acc, num) => acc + num, 0);
    let diff = (sumB - sumA) / 2;
    let setB = new Set(B);

    for (let a of A) {
        if (setB.has(a + diff)) {
            return [a, a + diff];
        }
    }
};