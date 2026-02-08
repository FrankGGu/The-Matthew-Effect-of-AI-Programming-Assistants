var checkMove = function(board, rMove, cMove, rEnd, cEnd) {
    const startPiece = board[rMove][cMove];
    const endPiece = board[rEnd][cEnd];

    if (startPiece === '.') {
        return false;
    }

    if (endPiece === '.') {
        return false;
    }

    if (rMove === rEnd && cMove === cEnd) {
        return false;
    }

    // Check if start and end pieces are of the same color
    if ((startPiece === 'W' && endPiece === 'W') || (startPiece === 'B' && endPiece === 'B')) {
        return false;
    }

    // Check if the move is along a straight line (horizontal, vertical, or diagonal)
    const isHorizontal = rMove === rEnd;
    const isVertical = cMove === cEnd;
    const isDiagonal = Math.abs(rMove - rEnd) === Math.abs(cMove - cEnd);

    if (!isHorizontal && !isVertical && !isDiagonal) {
        return false;
    }

    // Determine the direction of movement
    let dr = 0;
    if (rEnd > rMove) {
        dr = 1;
    } else if (rEnd < rMove) {
        dr = -1;
    }

    let dc = 0;
    if (cEnd > cMove) {
        dc = 1;
    } else if (cEnd < cMove) {
        dc = -1;
    }

    // Check intermediate squares
    let currR = rMove + dr;
    let currC = cMove + dc;

    while (currR !== rEnd || currC !== cEnd) {
        if (board[currR][currC] !== '.') {
            return false; // Path is blocked by another piece
        }
        currR += dr;
        currC += dc;
    }

    return true;
};