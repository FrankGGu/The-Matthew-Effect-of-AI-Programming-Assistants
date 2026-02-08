var minDominoRotations = function(A, B) {
    const check = (x) => {
        let rotationsA = 0, rotationsB = 0;
        for (let i = 0; i < A.length; i++) {
            if (A[i] !== x && B[i] !== x) return Infinity;
            if (A[i] !== x) rotationsA++;
            if (B[i] !== x) rotationsB++;
        }
        return Math.min(rotationsA, rotationsB);
    }

    let result = check(A[0]);
    if (A[0] !== B[0]) {
        result = Math.min(result, check(B[0]));
    }
    return result === Infinity ? -1 : result;
};