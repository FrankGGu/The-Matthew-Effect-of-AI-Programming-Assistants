var alphabetBoardPath = function(target) {
    let board = ["abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"];
    let x = 0;
    let y = 0;
    let result = "";

    for (let i = 0; i < target.length; i++) {
        let char = target[i];
        let targetX = 0;
        let targetY = 0;

        for (let row = 0; row < board.length; row++) {
            let col = board[row].indexOf(char);
            if (col !== -1) {
                targetX = row;
                targetY = col;
                break;
            }
        }

        let dx = targetX - x;
        let dy = targetY - y;

        if (dx < 0) {
            result += "U".repeat(Math.abs(dx));
        }
        if (dy < 0) {
            result += "L".repeat(Math.abs(dy));
        }
        if (dy > 0) {
            result += "R".repeat(dy);
        }
        if (dx > 0) {
            result += "D".repeat(dx);
        }

        result += "!";
        x = targetX;
        y = targetY;
    }

    return result;
};