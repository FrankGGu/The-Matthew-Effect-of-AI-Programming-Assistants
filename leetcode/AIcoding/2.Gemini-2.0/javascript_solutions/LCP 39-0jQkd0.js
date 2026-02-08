var minimumOperations = function(source, target, operations) {
    const n = source.length;
    const m = source[0].length;

    const sourceStr = source.map(row => row.join('')).join('');
    const targetStr = target.map(row => row.join('')).join('');

    if (sourceStr === targetStr) {
        return 0;
    }

    const adj = new Array(6).fill(null).map(() => []);
    for (const op of operations) {
        adj[op[0]].push([op[1], op[2]]);
    }

    const dist = new Array(6).fill(Infinity);
    dist[0] = 0;

    const queue = [0];

    while (queue.length > 0) {
        const u = queue.shift();

        for (const [v, cost] of adj[u]) {
            if (dist[u] + cost < dist[v]) {
                dist[v] = dist[u] + cost;
                queue.push(v);
            }
        }
    }
    return dist[1] === Infinity ? -1 : dist[1];
};