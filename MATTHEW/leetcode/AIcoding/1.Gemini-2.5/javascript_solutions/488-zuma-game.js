var findMinStep = function(board, hand) {
    const memo = new Map();

    function reduce(s) {
        if (s.length === 0) return "";
        let i = 0;
        while (i < s.length) {
            let j = i;
            while (j < s.length && s[j] === s[i]) {
                j++;
            }
            if (j - i >= 3) {
                return reduce(s.substring(0, i) + s.substring(j));
            }
            i = j;
        }
        return s;
    }

    const initialHandMap = new Map();
    for (const char of hand) {
        initialHandMap.set(char, (initialHandMap.get(char) || 0) + 1);
    }

    function dfs(currentBoard, currentHandMap) {
        const handKey = Array.from(currentHandMap.entries())
            .sort((a, b) => a[0].localeCompare(b[0]))
            .map(([char, count]) => char + count)
            .join('');
        const key = currentBoard + '#' + handKey;

        if (memo.has(key)) {
            return memo.get(key);
        }

        if (currentBoard === '') {
            return 0;
        }

        let minBalls = Infinity;

        for (const ball of currentHandMap.keys()) {
            if (currentHandMap.get(ball) > 0) {
                for (let i = 0; i <= currentBoard.length; i++) {
                    const newBoard = currentBoard.substring(0, i) + ball + currentBoard.substring(i);
                    const reducedBoard = reduce(newBoard);

                    currentHandMap.set(ball, currentHandMap.get(ball) - 1);

                    const result = dfs(reducedBoard, currentHandMap);

                    currentHandMap.set(ball, currentHandMap.get(ball) + 1);

                    if (result !== Infinity) {
                        minBalls = Math.min(minBalls, 1 + result);
                    }
                }
            }
        }

        memo.set(key, minBalls);
        return minBalls;
    }

    const result = dfs(board, initialHandMap);
    return result === Infinity ? -1 : result;
};