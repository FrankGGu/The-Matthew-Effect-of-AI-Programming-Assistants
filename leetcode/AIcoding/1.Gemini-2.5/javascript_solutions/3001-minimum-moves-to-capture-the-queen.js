var minMovesToCaptureTheQueen = function(rR, rC, bR, bC, qR, qC) {
    let canRookCapture = false;

    // Check if Rook can capture Queen horizontally
    if (rR === qR) {
        // Rook and Queen are on the same row.
        // Check if Bishop is blocking the path.
        if (bR === rR && ((bC > Math.min(rC, qC) && bC < Math.max(rC, qC)))) {
            // Bishop is on the same row and strictly between Rook and Queen.
            // Rook is blocked.
        } else {
            canRookCapture = true;
        }
    } 
    // Check if Rook can capture Queen vertically
    else if (rC === qC) {
        // Rook and Queen are on the same column.
        // Check if Bishop is blocking the path.
        if (bC === rC && ((bR > Math.min(rR, qR) && bR < Math.max(rR, qR)))) {
            // Bishop is on the same column and strictly between Rook and Queen.
            // Rook is blocked.
        } else {
            canRookCapture = true;
        }
    }

    if (canRookCapture) {
        return 1;
    }

    let canBishopCapture = false;

    // Check if Bishop can capture Queen diagonally
    if (Math.abs(bR - qR) === Math.abs(bC - qC)) {
        // Bishop and Queen are on the same diagonal.
        // Check if Rook is blocking the path.
        if (Math.abs(rR - bR) === Math.abs(rC - bC) && // Rook is on the same diagonal as Bishop (from Bishop's perspective)
            (rR > Math.min(bR, qR) && rR < Math.max(bR, qR)) && // Rook's row is strictly between Bishop's and Queen's
            (rC > Math.min(bC, qC) && rC < Math.max(bC, qC))) { // Rook's column is strictly between Bishop's and Queen's
            // Rook is on the same diagonal and strictly between Bishop and Queen.
            // Bishop is blocked.
        } else {
            canBishopCapture = true;
        }
    }

    if (canBishopCapture) {
        return 1;
    }

    // If neither Rook nor Bishop can capture the Queen in one move,
    // it will always take two moves for at least one of them.
    return 2;
};