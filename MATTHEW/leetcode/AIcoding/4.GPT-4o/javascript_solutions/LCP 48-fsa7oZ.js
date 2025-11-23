class InfiniteChessboard {
    constructor() {
        this.pieces = new Set();
    }

    addPiece(x, y) {
        this.pieces.add(`${x},${y}`);
    }

    canCapture(x1, y1, x2, y2) {
        if (!this.pieces.has(`${x1},${y1}`) || !this.pieces.has(`${x2},${y2}`)) {
            return false;
        }
        return Math.abs(x1 - x2) === Math.abs(y1 - y2) ||
               x1 === x2 || y1 === y2;
    }
}

var infiniteChessboard = new InfiniteChessboard();
infiniteChessboard.addPiece(0, 0);
infiniteChessboard.addPiece(1, 1);
); // true
); // false