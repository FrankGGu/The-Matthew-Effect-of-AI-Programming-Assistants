class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp();
    }

    pop() {
        if (this.isEmpty()) {
            return null;
        }
        const min = this.heap[0];
        const last = this.heap.pop();
        if (!this.isEmpty()) {
            this.heap[0] = last;
            this._bubbleDown();
        }
        return min;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp() {
        let idx = this.heap.length - 1;
        const element = this.heap[idx];
        while (idx > 0) {
            let parentIdx = Math.floor((idx - 1) / 2);
            let parent = this.heap[parentIdx];
            if (element[0] >= parent[0]) {
                break;
            }
            this.heap[parentIdx] = element;
            this.heap[idx] = parent;
            idx = parentIdx;
        }
    }

    _bubbleDown() {
        let idx = 0;
        const element = this.heap[idx];
        const len = this.heap.length;
        while (true) {
            let leftChildIdx = 2 * idx + 1;
            let rightChildIdx = 2 * idx + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIdx < len) {
                leftChild = this.heap[leftChildIdx];
                if (leftChild[0] < element[0]) {
                    swap = leftChildIdx;
                }
            }

            if (rightChildIdx < len) {
                rightChild = this.heap[rightChildIdx];
                if (
                    (swap === null && rightChild[0] < element[0]) ||
                    (swap !== null && rightChild[0] < leftChild[0])
                ) {
                    swap = rightChildIdx;
                }
            }

            if (swap === null) {
                break;
            }
            this.heap[idx] = this.heap[swap];
            this.heap[swap] = element;
            idx = swap;
        }
    }
}

var transferTokens = function(n, edges, k) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
    }

    const dist = new Array(n).fill(Infinity);
    dist[0] = 0;

    const pq = new MinHeap();
    pq.push([0, 0]); // [cost, node]

    while (!pq.isEmpty()) {
        const [currentCost, u] = pq.pop();

        if (currentCost > dist[u]) {
            continue;
        }

        for (const [v, weight] of adj[u]) {
            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                pq.push([dist[v], v]);
            }
        }
    }

    if (dist[n - 1] === Infinity) {
        return -1;
    }

    return dist[n - 1] * k;
};