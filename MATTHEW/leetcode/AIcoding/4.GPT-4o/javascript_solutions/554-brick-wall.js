var leastBricks = function(wall) {
    const edgeCount = new Map();
    for (const row of wall) {
        let edgePosition = 0;
        for (let i = 0; i < row.length - 1; i++) {
            edgePosition += row[i];
            edgeCount.set(edgePosition, (edgeCount.get(edgePosition) || 0) + 1);
        }
    }
    let maxEdges = 0;
    for (const count of edgeCount.values()) {
        maxEdges = Math.max(maxEdges, count);
    }
    return wall.length - maxEdges;
};