var edgeScore = function(edges) {
    const n = edges.length;
    const scores = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const to = edges[i];
        scores[to] += i;
    }

    let maxScore = -1;
    let result = 0;

    for (let i = 0; i < n; i++) {
        if (scores[i] > maxScore) {
            maxScore = scores[i];
            result = i;
        } else if (scores[i] === maxScore && i < result) {
            result = i;
        }
    }

    return result;
};