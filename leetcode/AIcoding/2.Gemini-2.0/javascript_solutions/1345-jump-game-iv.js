var minJumps = function(arr) {
    const n = arr.length;
    if (n <= 1) return 0;

    const adj = new Map();
    for (let i = 0; i < n; i++) {
        if (!adj.has(arr[i])) {
            adj.set(arr[i], []);
        }
        adj.get(arr[i]).push(i);
    }

    const visited = new Array(n).fill(false);
    const q = [];
    q.push(0);
    visited[0] = true;
    let steps = 0;

    while (q.length > 0) {
        const size = q.length;
        for (let i = 0; i < size; i++) {
            const u = q.shift();
            if (u === n - 1) return steps;

            const neighbors = adj.get(arr[u]);
            neighbors.push(u - 1);
            neighbors.push(u + 1);

            for (const v of neighbors) {
                if (v >= 0 && v < n && !visited[v]) {
                    q.push(v);
                    visited[v] = true;
                }
            }

            adj.set(arr[u], []);
        }
        steps++;
    }

    return -1;
};