var queensAttacktheKing = function(queens, king) {
    const directions = [
        [-1, 0], [1, 0], [0, -1], [0, 1], 
        [-1, -1], [-1, 1], [1, -1], [1, 1]
    ];
    const queensSet = new Set(queens.map(q => q.join(',')));
    const result = [];

    for (const [dx, dy] of directions) {
        let x = king[0], y = king[1];
        while (x >= 0 && x < 8 && y >= 0 && y < 8) {
            if (queensSet.has(`${x},${y}`)) {
                result.push([x, y]);
                break;
            }
            x += dx;
            y += dy;
        }
    }

    return result;
};