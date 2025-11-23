var modifyGraphEdges = function(n, edges, inc) {
    let modifiedEdges = [];
    let originalEdges = new Set(edges.map(edge => edge.join(',')));

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (!originalEdges.has([i, j].join(',')) && !originalEdges.has([j, i].join(','))) {
                modifiedEdges.push([j, i, inc]);
            }
        }
    }

    return modifiedEdges.concat(edges);
};