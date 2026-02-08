var minFlips = function(mat) {
    const m = mat.length, n = mat[0].length;
    const dirs = [[0, 0], [0, 1], [0, -1], [1, 0], [-1, 0]];
    let steps = 0;
    let queue = [];
    let visited = new Set();
    let start = '';

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            start += mat[i][j];
        }
    }

    if (start === '0'.repeat(m * n)) return 0;

    queue.push(start);
    visited.add(start);

    while (queue.length > 0) {
        let size = queue.length;
        steps++;

        for (let i = 0; i < size; i++) {
            let curr = queue.shift();

            for (let pos = 0; pos < m * n; pos++) {
                let temp = curr.split('');

                let x = Math.floor(pos / n);
                let y = pos % n;

                for (const [dx, dy] of dirs) {
                    let nx = x + dx;
                    let ny = y + dy;

                    if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                        let idx = nx * n + ny;
                        temp[idx] = temp[idx] === '1' ? '0' : '1';
                    }
                }

                let next = temp.join('');

                if (next === '0'.repeat(m * n)) {
                    return steps;
                }

                if (!visited.has(next)) {
                    visited.add(next);
                    queue.push(next);
                }
            }
        }
    }

    return -1;
};