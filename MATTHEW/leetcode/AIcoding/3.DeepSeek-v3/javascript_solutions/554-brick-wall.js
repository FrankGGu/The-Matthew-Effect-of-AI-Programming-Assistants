var leastBricks = function(wall) {
    const edgeCount = new Map();
    let maxEdges = 0;

    for (const row of wall) {
        let edgePos = 0;
        for (let i = 0; i < row.length - 1; i++) {
            edgePos += row[i];
            edgeCount.set(edgePos, (edgeCount.get(edgePos) || 0) + 1);
            maxEdges = Math.max(maxEdges, edgeCount.get(edgePos));
        }
    }

    return wall.length - maxEdges;
};