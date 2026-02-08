function stoneGameVI(aliceScores, bobScores) {
    const n = aliceScores.length;
    const pairs = Array.from({ length: n }, (_, i) => [aliceScores[i], bobScores[i]]);

    pairs.sort((a, b) => (b[0] + b[1]) - (a[0] + a[1]));

    let aliceTotal = 0;
    let bobTotal = 0;

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            aliceTotal += pairs[i][0];
        } else {
            bobTotal += pairs[i][1];
        }
    }

    if (aliceTotal > bobTotal) return 1;
    if (bobTotal > aliceTotal) return -1;
    return 0;
}