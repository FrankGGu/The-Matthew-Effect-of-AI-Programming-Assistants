var shortestDistanceAfterRoadAdditionQueries = function(n, roads, queries) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v, w] of roads) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const dist = Array.from({ length: n }, () => new Array(n).fill(Infinity));
    for (let i = 0; i < n; i++) {
        dist[i][i] = 0;
        const heap = new MinHeap();
        heap.push([0, i]);
        while (heap.size() > 0) {
            const [d, u] = heap.pop();
            if (d > dist[i][u]) continue;
            for (const [v, w] of adj[u]) {
                if (dist[i][v] > d + w) {
                    dist[i][v] = d + w;
                    heap.push([dist[i][v], v]);
                }
            }
        }
    }

    const res = [];
    for (const [x, y, w] of queries) {
        let minDist = dist[x][y];
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                minDist = Math.min(minDist, dist[x][i] + w + dist[j][y]);
            }
        }
        res.push(minDist);
    }
    return res;
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        const min = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.bubbleDown(0);
        }
        return min;
    }

    size() {
        return this.heap.length;
    }

    bubbleUp(idx) {
        const element = this.heap[idx];
        while (idx > 0) {
            const parentIdx = Math.floor((idx - 1) / 2);
            const parent = this.heap[parentIdx];
            if (element[0] >= parent[0]) break;
            this.heap[idx] = parent;
            idx = parentIdx;
        }
        this.heap[idx] = element;
    }

    bubbleDown(idx) {
        const element = this.heap[idx];
        const length = this.heap.length;
        while (true) {
            let leftChildIdx = 2 * idx + 1;
            let rightChildIdx = 2 * idx + 2;
            let swap = null;
            if (leftChildIdx < length) {
                const leftChild = this.heap[leftChildIdx];
                if (leftChild[0] < element[0]) {
                    swap = leftChildIdx;
                }
            }
            if (rightChildIdx < length) {
                const rightChild = this.heap[rightChildIdx];
                if (
                    (swap === null && rightChild[0] < element[0]) ||
                    (swap !== null && rightChild[0] < this.heap[swap][0])
                ) {
                    swap = rightChildIdx;
                }
            }
            if (swap === null) break;
            this.heap[idx] = this.heap[swap];
            idx = swap;
        }
        this.heap[idx] = element;
    }
}