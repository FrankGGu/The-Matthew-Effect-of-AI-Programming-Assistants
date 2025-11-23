class Solution {
    reachableNodes(edges, maxMoves, n) {
        const graph = new Map();
        for (const [u, v, cnt] of edges) {
            if (!graph.has(u)) graph.set(u, []);
            if (!graph.has(v)) graph.set(v, []);
            graph.get(u).push([v, cnt]);
            graph.get(v).push([u, cnt]);
        }

        const pq = new MinPriorityQueue();
        pq.enqueue([0, 0]); // [moves, node]
        const visited = new Set();
        const reachable = new Array(n).fill(0);

        while (!pq.isEmpty()) {
            const [moves, node] = pq.dequeue().element;
            if (visited.has(node)) continue;
            visited.add(node);
            reachable[node]++;

            if (moves < maxMoves) {
                for (const [next, cnt] of graph.get(node) || []) {
                    const newMoves = moves + 1;
                    if (!visited.has(next)) {
                        pq.enqueue([newMoves, next]);
                        reachable[next] += Math.max(0, cnt - (maxMoves - newMoves));
                    }
                }
            }
        }

        return reachable.reduce((acc, val) => acc + val, visited.size);
    }
}