var findMinStep = function(board, hand) {
    let minSteps = Infinity;
    const handMap = {};
    for (const char of hand) {
        handMap[char] = (handMap[char] || 0) + 1;
    }

    function cleanBoard(board) {
        let prevLength = board.length;
        while (true) {
            let newBoard = "";
            let i = 0;
            while (i < board.length) {
                let j = i;
                while (j < board.length && board[i] === board[j]) {
                    j++;
                }
                if (j - i >= 3) {
                    i = j;
                } else {
                    newBoard += board.substring(i, j);
                    i = j;
                }
            }
            board = newBoard;
            if (board.length === prevLength) {
                break;
            }
            prevLength = board.length;
        }
        return board;
    }

    function backtrack(currentBoard, currentHandMap, steps) {
        if (currentBoard === "") {
            minSteps = Math.min(minSteps, steps);
            return;
        }

        if (steps >= minSteps) return;

        for (let i = 0; i < currentBoard.length; i++) {
            for (const color in currentHandMap) {
                if (currentHandMap[color] > 0) {
                    const newHandMap = { ...currentHandMap };
                    newHandMap[color]--;
                    let newBoard = currentBoard.substring(0, i) + color + currentBoard.substring(i);
                    newBoard = cleanBoard(newBoard);
                    backtrack(newBoard, newHandMap, steps + 1);
                }
            }
        }
    }

    backtrack(board, handMap, 0);

    return minSteps === Infinity ? -1 : minSteps;
};