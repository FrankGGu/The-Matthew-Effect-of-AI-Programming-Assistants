var minimumWeight = function(n, edges, source1, source2, dest) {
    // MinHeap implementation for Dijkstra's algorithm
    class MinHeap {
        constructor() {
            this.heap = [];
        }

        push(val) {
            this.heap.push(val);
            this.bubbleUp(this.heap.length - 1);
        }

        pop() {
            if (this.heap.length === 0) return null;
            if (this.heap.length === 1) return this.heap.pop();

            const min = this.heap[0];
            this.heap[0] = this.heap.pop();
            this.bubbleDown(0);
            return min;
        }

        size() {
            return this.heap.length;
        }

        bubbleUp(idx) {
            while (idx > 0) {
                const parentIdx = Math.floor((idx - 1) / 2);
                if (this.heap[parentIdx][0] > this.heap[idx][0]) {
                    [this.heap[parentIdx], this.heap[idx]] = [this.heap[idx], this.heap[parentIdx]];
                    idx = parentIdx;
                } else {
                    break;
                }
            }
        }

        bubbleDown(idx) {
            const lastIdx = this.heap.length - 1;
            while (true) {
                const leftChildIdx = 2 * idx + 1;
                const rightChildIdx = 2 * idx + 2;
                let smallestIdx = idx;

                if (leftChildIdx <= lastIdx && this.heap[leftChildIdx][0] < this.heap[smallestIdx][0]) {
                    smallestIdx = leftChildIdx;
                }

                if (rightChildIdx <= lastIdx && this.heap[rightChildIdx][0] < this.heap[smallestIdx][0]) {
                    smallestIdx = rightChildIdx;
                }

                if (smallestIdx !== idx) {
                    [this.heap[idx], this.heap[smallestIdx]] = [this.heap[smallestIdx], this.heap[idx]];
                    idx = smallestIdx;
                } else {
                    break;
                }
            }
        }
    }

    // Dijkstra's algorithm helper function
    const dijkstra = (numNodes, graph, startNode) => {
        const dist = new Array(numNodes).fill(Infinity);
        dist[startNode] = 0;

        const minHeap = new MinHeap();
        minHeap.push([0, startNode]); // [distance, node]

        while (minHeap.size() > 0) {
            const [d, u] = minHeap.pop();

            if (d > dist[u]) {
                continue;
            }

            if (graph[u]) {
                for (const [v, weight] of graph[u]) {
                    if (dist[u] + weight < dist[v]) {
                        dist[v] = dist[u] + weight;
                        minHeap.push([dist[v], v]);
                    }
                }
            }
        }
        return dist;
    };

    // Build adjacency lists for original and reversed graphs
    const adj = new Array(n).fill(0).map(() => []); // Original graph: u -> [[v, w], ...]
    const revAdj = new Array(n).fill(0).map(() => []); // Reversed graph: v -> [[u, w], ...]

    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        revAdj[v].push([u, w]);
    }

    // Run Dijkstra from source1 on the original graph
    const distFromS1 = dijkstra(n, adj, source1);

    // Run Dijkstra from source2 on the original graph
    const distFromS2 = dijkstra(n, adj, source2);

    // Run Dijkstra from dest on the reversed graph (to find paths TO dest)
    const distToDest = dijkstra(n, revAdj, dest);

    // Iterate through all possible intermediate nodes 'u'
    let minTotalWeight = Infinity;
    for (let u = 0; u < n; u++) {
        if (distFromS1[u] !== Infinity && distFromS2[u] !== Infinity && distToDest[u] !== Infinity) {
            minTotalWeight = Math.min(minTotalWeight, distFromS1[u] + distFromS2[u] + distToDest[u]);
        }
    }

    return minTotalWeight === Infinity ? -1 : minTotalWeight;
};