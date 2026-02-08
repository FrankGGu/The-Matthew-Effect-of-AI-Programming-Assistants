var alphabetBoardPath = function(target) {
    const board = ["abcde", "fghij", "klmno", "pqrst", "uvwxy", "z"];
    const posMap = {};
    for (let i = 0; i < board.length; i++) {
        for (let j = 0; j < board[i].length; j++) {
            posMap[board[i][j]] = [i, j];
        }
    }

    let res = [];
    let current = [0, 0];

    for (const char of target) {
        const targetPos = posMap[char];
        const [x, y] = targetPos;
        const [cx, cy] = current;

        let dx = x - cx;
        let dy = y - cy;

        if (char === 'z') {
            while (dy < 0) {
                res.push('L');
                dy++;
            }
            while (dy > 0) {
                res.push('R');
                dy--;
            }
            while (dx > 0) {
                res.push('D');
                dx--;
            }
        } else {
            while (dx < 0) {
                res.push('U');
                dx++;
            }
            while (dx > 0) {
                res.push('D');
                dx--;
            }
            while (dy < 0) {
                res.push('L');
                dy++;
            }
            while (dy > 0) {
                res.push('R');
                dy--;
            }
        }

        res.push('!');
        current = [x, y];
    }

    return res.join('');
};