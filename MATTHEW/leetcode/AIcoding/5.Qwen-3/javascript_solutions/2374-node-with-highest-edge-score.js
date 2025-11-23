function mostVisitedNode(edges) {
    const n = edges.length;
    const score = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const neighbor = edges[i];
        score[neighbor]++;
    }

    let maxScore = -1;
    let result = 0;

    for (let i = 0; i < n; i++) {
        if (score[i] > maxScore) {
            maxScore = score[i];
            result = i;
        }
    }

    return result;
}