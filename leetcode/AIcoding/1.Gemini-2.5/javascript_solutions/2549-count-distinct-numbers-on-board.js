var countDistinctNumbers = function(n) {
    const board = new Set();
    const queue = [];

    board.add(n);
    queue.push(n);

    let head = 0;
    while (head < queue.length) {
        const currentNum = queue[head++];

        for (let i = 1; i <= n; i++) {
            if (currentNum % i === 1) {
                const newNum = currentNum - i;
                if (newNum > 0 && !board.has(newNum)) {
                    board.add(newNum);
                    queue.push(newNum);
                }
            }
        }
    }

    return board.size;
};