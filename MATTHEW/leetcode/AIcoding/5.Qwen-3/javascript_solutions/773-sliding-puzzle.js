function slidingPuzzle(board) {
    const target = "12345678";
    const start = board.flat().join('');

    const neighbors = [
        [1, 3],
        [0, 2, 4],
        [1, 5],
        [0, 4],
        [1, 3, 5, 7],
        [2, 4, 8],
        [3, 7],
        [6, 8],
        [5, 7]
    ];

    const queue = [[start, 0]];
    const visited = new Set([start]);

    while (queue.length > 0) {
        const [current, steps] = queue.shift();

        if (current === target) return steps;

        const index = current.indexOf('0');

        for (const neighbor of neighbors[index]) {
            const arr = current.split('');
            [arr[index], arr[neighbor]] = [arr[neighbor], arr[index]];
            const next = arr.join('');

            if (!visited.has(next)) {
                visited.add(next);
                queue.push([next, steps + 1]);
            }
        }
    }

    return -1;
}