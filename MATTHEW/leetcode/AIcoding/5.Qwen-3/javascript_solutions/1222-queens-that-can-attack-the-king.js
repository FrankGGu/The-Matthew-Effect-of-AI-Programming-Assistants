function queensAttacktheKing(queens, king) {
    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],          [0, 1],
        [1, -1],  [1, 0], [1, 1]
    ];
    const result = [];
    const queenSet = new Set(queens.map(q => q[0] + ',' + q[1]));
    for (const [dx, dy] of directions) {
        let x = king[0], y = king[1];
        while (true) {
            x += dx;
            y += dy;
            if (x < 0 || x >= 8 || y < 0 || y >= 8) break;
            const key = x + ',' + y;
            if (queenSet.has(key)) {
                result.push([x, y]);
                break;
            }
        }
    }
    return result;
}