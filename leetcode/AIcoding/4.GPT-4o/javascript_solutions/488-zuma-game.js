var findMinStep = function(board, hand) {
    const memo = {};

    const dfs = (board, hand) => {
        if (board.length === 0) return 0;
        const key = board + '-' + hand;
        if (key in memo) return memo[key];

        let minSteps = Infinity;
        for (let i = 0; i < hand.length; i++) {
            const newBoard = removeConsecutive(board + hand[i]);
            const nextHand = hand.slice(0, i) + hand.slice(i + 1);
            const steps = dfs(newBoard, nextHand);
            if (steps >= 0) {
                minSteps = Math.min(minSteps, steps + 1);
            }
        }

        memo[key] = (minSteps === Infinity) ? -1 : minSteps;
        return memo[key];
    };

    const removeConsecutive = (board) => {
        let i = 0;
        while (i < board.length) {
            let j = i;
            while (j < board.length && board[j] === board[i]) {
                j++;
            }
            if (j - i >= 3) {
                board = board.slice(0, i) + board.slice(j);
                i = 0;
            } else {
                i++;
            }
        }
        return board;
    };

    return dfs(board, hand);
};