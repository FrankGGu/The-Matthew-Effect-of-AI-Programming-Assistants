var slidingPuzzle = function(board) {
    const target = "123450";
    const initial = board.flat().join('');

    if (initial === target) {
        return 0;
    }

    const queue = [[initial, 0]];
    const visited = new Set();
    visited.add(initial);

    const neighbors = [
        [1, 3],
        [0, 2, 4],
        [1, 5],
        [0, 4],
        [1, 3, 5],
        [2, 4]
    ];

    while (queue.length > 0) {
        const [currentBoard, steps] = queue.shift();

        const zeroIndex = currentBoard.indexOf('0');

        for (const nextZeroIndex of neighbors[zeroIndex]) {
            const newBoardArray = currentBoard.split('');
            [newBoardArray[zeroIndex], newBoardArray[nextZeroIndex]] = [newBoardArray[nextZeroIndex], newBoardArray[zeroIndex]];
            const newBoard = newBoardArray.join('');

            if (newBoard === target) {
                return steps + 1;
            }

            if (!visited.has(newBoard)) {
                visited.add(newBoard);
                queue.push([newBoard, steps + 1]);
            }
        }
    }

    return -1;
};