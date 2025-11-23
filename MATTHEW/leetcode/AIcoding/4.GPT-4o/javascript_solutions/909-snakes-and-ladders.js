class Solution {
    bfs(start, end, board) {
        const queue = [start];
        const visited = new Set();
        visited.add(start);
        let steps = 0;

        while (queue.length) {
            const size = queue.length;
            for (let i = 0; i < size; i++) {
                const current = queue.shift();
                if (current === end) return steps;

                for (let j = 1; j <= 6; j++) {
                    let next = current + j;
                    if (next > end) continue;
                    const row = Math.floor((next - 1) / 6);
                    const col = (next - 1) % 6;
                    const square = board[row][col];

                    if (square !== -1) {
                        next = square;
                    }

                    if (!visited.has(next)) {
                        visited.add(next);
                        queue.push(next);
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    snakesAndLadders(board) {
        const n = board.length;
        const end = n * n;
        return this.bfs(1, end, board);
    }
}