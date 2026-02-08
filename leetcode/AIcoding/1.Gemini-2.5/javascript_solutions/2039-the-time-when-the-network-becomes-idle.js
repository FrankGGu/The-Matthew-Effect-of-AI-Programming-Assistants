var networkBecomesIdle = function(edges, patience) {
    const n = patience.length;

    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const dist = new Array(n).fill(Infinity);
    const queue = [];

    dist[0] = 0;
    queue.push(0);

    let head = 0;
    while (head < queue.length) {
        const u = queue[head++];

        for (const v of adj[u]) {
            if (dist[v] === Infinity) {
                dist[v] = dist[u] + 1;
                queue.push(v);
            }
        }
    }

    let maxLastMessageArrivalTime = 0;

    for (let i = 1; i < n; i++) {
        const d = dist[i];
        const p = patience[i];

        const roundTripTime = 2 * d;

        let currentServerLastArrivalTime;

        if (roundTripTime <= p) {
            currentServerLastArrivalTime = roundTripTime;
        } else {
            const numRetransmissions = Math.floor((roundTripTime - 1) / p);
            const lastRetransmissionStartTime = numRetransmissions * p;
            currentServerLastArrivalTime = lastRetransmissionStartTime + d;
        }

        maxLastMessageArrivalTime = Math.max(maxLastMessageArrivalTime, currentServerLastArrivalTime);
    }

    return maxLastMessageArrivalTime + 1;
};