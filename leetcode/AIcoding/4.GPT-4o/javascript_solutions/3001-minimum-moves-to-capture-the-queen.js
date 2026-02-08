var minQueenMoves = function(queen, king) {
    const [qx, qy] = queen;
    const [kx, ky] = king;

    return Math.max(Math.abs(qx - kx), Math.abs(qy - ky));
};