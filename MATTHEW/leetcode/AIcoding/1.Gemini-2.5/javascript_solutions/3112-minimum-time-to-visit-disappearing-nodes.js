class MinPriorityQueue {
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
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._sinkDown();
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

    _sinkDown() {
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
            if (swap === null) {
                break;
            }
            this.heap[idx] = this.heap[swap];
            this.heap[swap] = element;
            idx = swap;
        }
    }
}

var minimumTime = function(n, disappear, edges) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const minTime = Array(n).fill(Infinity);
    const pq = new MinPriorityQueue();

    minTime[0] = 0;
    pq.push([0, 0]);

    while (!pq.isEmpty()) {
        const [currentTime, u] = pq.pop();

        if (currentTime > minTime[u]) {
            continue;
        }

        for (const [v, weight] of adj[u]) {
            const newTime = currentTime + weight;

            if (newTime < disappear[v] && newTime < minTime[v]) {
                minTime[v] = newTime;
                pq.push([newTime, v]);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (minTime[i] === Infinity) {
            minTime[i] = -1;
        }
    }

    return minTime;
};