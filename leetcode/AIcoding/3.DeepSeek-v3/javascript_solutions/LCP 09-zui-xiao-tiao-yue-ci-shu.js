var minJump = function(jump) {
    const n = jump.length;
    const visited = new Array(n).fill(false);
    const queue = [];
    queue.push(0);
    visited[0] = true;
    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const current = queue.shift();
            if (current + jump[current] >= n) {
                return steps + 1;
            }
            if (!visited[current + jump[current]]) {
                visited[current + jump[current]] = true;
                queue.push(current + jump[current]);
            }
            for (let j = current - 1; j >= 0; j--) {
                if (visited[j]) break;
                visited[j] = true;
                queue.push(j);
            }
        }
        steps++;
    }
    return -1;
};