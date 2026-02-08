var highestEdgeScore = function(edges) {
    const score = new Array(edges.length).fill(0);
    for (let i = 0; i < edges.length; i++) {
        score[edges[i]] += i;
    }
    let maxScore = -1, node = -1;
    for (let i = 0; i < score.length; i++) {
        if (score[i] > maxScore || (score[i] === maxScore && i < node)) {
            maxScore = score[i];
            node = i;
        }
    }
    return node;
};