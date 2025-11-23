var leastBricks = function(wall) {
    const gaps = new Map();
    let maxGaps = 0;

    for (const row of wall) {
        let position = 0;
        for (let i = 0; i < row.length - 1; i++) {
            position += row[i];
            gaps.set(position, (gaps.get(position) || 0) + 1);
            maxGaps = Math.max(maxGaps, gaps.get(position));
        }
    }

    return wall.length - maxGaps;
};