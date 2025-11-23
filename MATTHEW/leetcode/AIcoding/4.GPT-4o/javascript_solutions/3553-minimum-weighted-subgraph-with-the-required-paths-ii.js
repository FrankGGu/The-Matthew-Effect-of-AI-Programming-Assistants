class Graph {
    constructor(n) {
        this.edges = Array.from({ length: n }, () => []);
    }

    addEdge(u, v, weight) {
        this.edges[u].push({ node: v, weight });
        this.edges[v].push({ node: u, weight });
    }
}

var minWeight = function(n, edges, src1, src2, dest) {
    const graph = new Graph(n);
    for (const [u, v, weight] of edges) {
        graph.addEdge(u, v, weight);
    }

    const dijkstra = (start) => {
        const distances = Array(n).fill(Infinity);
        distances[start] = 0;
        const minHeap = [[0, start]];

        while (minHeap.length) {
            const [currentDist, currentNode] = minHeap.shift();
            if (currentDist > distances[currentNode]) continue;

            for (const { node, weight } of graph.edges[currentNode]) {
                const newDist = currentDist + weight;
                if (newDist < distances[node]) {
                    distances[node] = newDist;
                    minHeap.push([newDist, node]);
                    minHeap.sort((a, b) => a[0] - b[0]);
                }
            }
        }
        return distances;
    };

    const distFromSrc1 = dijkstra(src1);
    const distFromSrc2 = dijkstra(src2);
    const distFromDest = dijkstra(dest);

    const result = Math.min(
        distFromSrc1[dest] + distFromSrc2[dest],
        distFromSrc1[src2] + distFromSrc2[dest],
        distFromSrc2[src1] + distFromSrc1[dest]
    );

    return result === Infinity ? -1 : result;
};