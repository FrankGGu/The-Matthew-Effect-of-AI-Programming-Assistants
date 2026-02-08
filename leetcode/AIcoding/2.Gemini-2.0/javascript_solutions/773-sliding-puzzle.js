var slidingPuzzle = function(board) {
    const target = "123450";
    let start = board[0].join("") + board[1].join("");
    const neighbors = [[1, 3], [0, 2, 4], [1, 5], [0, 4], [1, 3, 5], [2, 4]];
    const queue = [start];
    const visited = new Set([start]);
    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const current = queue.shift();
            if (current === target) {
                return steps;
            }

            const zeroIndex = current.indexOf("0");
            for (const neighbor of neighbors[zeroIndex]) {
                let next = current.split("");
                [next[zeroIndex], next[neighbor]] = [next[neighbor], next[zeroIndex]];
                next = next.join("");

                if (!visited.has(next)) {
                    queue.push(next);
                    visited.add(next);
                }
            }
        }
        steps++;
    }

    return -1;
};