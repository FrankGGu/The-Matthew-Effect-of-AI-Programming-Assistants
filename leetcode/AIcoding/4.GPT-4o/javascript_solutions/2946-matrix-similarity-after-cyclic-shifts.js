function areSimilar(A, B) {
    const n = A.length;
    const countA = new Array(101).fill(0);
    const countB = new Array(101).fill(0);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            countA[A[i][j]]++;
            countB[B[i][j]]++;
        }
    }

    for (let i = 0; i < 101; i++) {
        if (countA[i] !== countB[i]) {
            return false;
        }
    }

    return true;
}