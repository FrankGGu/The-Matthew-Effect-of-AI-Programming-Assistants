class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this.bubbleUp();
    }

    pop() {
        if (this.isEmpty()) return null;
        if (this.heap.length === 1) return this.heap.pop();
        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.sinkDown();
        return min;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp() {
        let idx = this.heap.length - 1;
        const element = this.heap[idx];
        while (idx > 0) {
            let parentIdx = Math.floor((idx - 1) / 2);
            let parent = this.heap[parentIdx];
            if (element[0] >= parent[0]) break;
            this.heap[parentIdx] = element;
            this.heap[idx] = parent;
            idx = parentIdx;
        }
    }

    sinkDown() {
        let idx = 0;
        const length = this.heap.length;
        const element = this.heap[0];
        while (true) {
            let leftChildIdx = 2 * idx + 1;
            let rightChildIdx = 2 * idx + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIdx < length) {
                leftChild = this.heap[leftChildIdx];
                if (leftChild[0] < element[0]) {
                    swap = leftChildIdx;
                }
            }

            if (rightChildIdx < length) {
                rightChild = this.heap[rightChildIdx];
                if (
                    (swap === null && rightChild[0] < element[0]) ||
                    (swap !== null && rightChild[0] < leftChild[0])
                ) {
                    swap = rightChildIdx;
                }
            }

            if (swap === null) break;
            this.heap[idx] = this.heap[swap];
            this.heap[swap] = element;
            idx = swap;
        }
    }
}

function dijkstra(n, graph, startNode) {
    const dist = new Array(n).fill(Infinity);
    dist[startNode] = 0;

    const minHeap = new MinHeap();
    minHeap.push([0, startNode]);

    while (!minHeap.isEmpty()) {
        const [d, u] = minHeap.pop();

        if (d > dist[u]) {
            continue;
        }

        for (const [v, weight] of graph[u]) {
            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                minHeap.push([dist[v], v]);
            }
        }
    }
    return dist;
}

var minimumWeight = function(n, edges, src1, src2, dest) {
    const adj = Array.from({ length: n }, () => []);
    const revAdj = Array.from({ length: n }, () => []);

    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        revAdj[v].push([u, w]);
    }

    const dist1 = dijkstra(n, adj, src1);
    const dist2 = dijkstra(n, adj, src2);
    const distDestRev = dijkstra(n, revAdj, dest);

    let minTotalWeight = Infinity;

    for (let m = 0; m < n; m++) {
        if (dist1[m] !== Infinity && dist2[m] !== Infinity && distDestRev[m] !== Infinity) {
            minTotalWeight = Math.min(minTotalWeight, dist1[m] + dist2[m] + distDestRev[m]);
        }
    }

    return minTotalWeight === Infinity ? -1 : minTotalWeight;
};