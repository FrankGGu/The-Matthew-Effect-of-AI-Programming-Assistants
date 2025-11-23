function minOperations(A, B) {
    if (A.length !== B.length) return -1;

    const countA = new Array(101).fill(0);
    const countB = new Array(101).fill(0);

    for (const num of A) countA[num]++;
    for (const num of B) countB[num]++;

    let totalOps = 0;
    let totalPairs = 0;

    for (let i = 1; i <= 100; i++) {
        if (countA[i] > countB[i]) {
            totalPairs += (countA[i] - countB[i]) / 2;
        } else {
            totalOps += (countB[i] - countA[i]) / 2;
        }
    }

    return totalPairs === totalOps ? totalOps : -1;
}