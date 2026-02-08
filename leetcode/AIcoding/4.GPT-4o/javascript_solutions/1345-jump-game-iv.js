var minJumps = function(arr) {
    const n = arr.length;
    if (n === 1) return 0;

    const graph = new Map();
    for (let i = 0; i < n; i++) {
        if (!graph.has(arr[i])) graph.set(arr[i], []);
        graph.get(arr[i]).push(i);
    }

    const queue = [0];
    const visited = new Set();
    visited.add(0);
    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const index = queue.shift();
            if (index === n - 1) return steps;

            const nextIndices = graph.get(arr[index]) || [];
            nextIndices.forEach(nextIndex => {
                if (!visited.has(nextIndex)) {
                    visited.add(nextIndex);
                    queue.push(nextIndex);
                }
            });

            if (index + 1 < n && !visited.has(index + 1)) {
                visited.add(index + 1);
                queue.push(index + 1);
            }

            if (index - 1 >= 0 && !visited.has(index - 1)) {
                visited.add(index - 1);
                queue.push(index - 1);
            }
        }
        steps++;
    }

    return -1;
};