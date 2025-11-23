function leastBricks(wall) {
    const map = {};
    let max = 0;

    for (const row of wall) {
        let pos = 0;
        for (let i = 0; i < row.length - 1; i++) {
            pos += row[i];
            map[pos] = (map[pos] || 0) + 1;
            if (map[pos] > max) {
                max = map[pos];
            }
        }
    }

    return wall.length - max;
}