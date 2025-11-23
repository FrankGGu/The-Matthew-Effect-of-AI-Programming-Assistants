function bestRotation(A) {
    const n = A.length;
    const score = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const left = (i - A[i] + 1 + n) % n;
        const right = (i + 1) % n;
        score[left] += 1;
        score[right] -= 1;
    }

    let maxScore = 0;
    let currentScore = 0;
    let bestK = 0;

    for (let k = 0; k < n; k++) {
        currentScore += score[k];
        if (currentScore > maxScore) {
            maxScore = currentScore;
            bestK = k;
        }
    }

    return bestK;
}