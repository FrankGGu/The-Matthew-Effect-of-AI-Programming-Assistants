var edgeScore = function(edges) {
    const n = edges.length;
    const scores = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const targetNode = edges[i];
        scores[targetNode] += i;
    }

    let maxScore = -1;
    let maxNode = -1;

    for (let i = 0; i < n; i++) {
        if (scores[i] > maxScore) {
            maxScore = scores[i];
            maxNode = i;
        }
    }

    return maxNode;
};