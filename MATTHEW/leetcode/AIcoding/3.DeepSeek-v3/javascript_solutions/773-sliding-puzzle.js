var slidingPuzzle = function(board) {
    const target = '123450';
    const moves = [
        [1, 3],
        [0, 2, 4],
        [1, 5],
        [0, 4],
        [1, 3, 5],
        [2, 4]
    ];

    let state = '';
    for (let row of board) {
        for (let num of row) {
            state += num;
        }
    }

    const visited = new Set();
    const queue = [[state, 0]];

    while (queue.length > 0) {
        const [current, steps] = queue.shift();
        if (current === target) return steps;

        const zeroIndex = current.indexOf('0');
        for (let move of moves[zeroIndex]) {
            const next = swap(current, zeroIndex, move);
            if (!visited.has(next)) {
                visited.add(next);
                queue.push([next, steps + 1]);
            }
        }
    }

    return -1;
};

function swap(s, i, j) {
    const arr = s.split('');
    [arr[i], arr[j]] = [arr[j], arr[i]];
    return arr.join('');
}