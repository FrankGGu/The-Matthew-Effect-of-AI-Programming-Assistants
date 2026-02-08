class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp();
    }

    pop() {
        if (this.isEmpty()) return null;
        if (this.heap.length === 1) return this.heap.pop();

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
            if (element[0] >= parent[0]) break;
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

            if (swap === null) break;
            this.heap[idx] = this.heap[swap];
            this.heap[swap] = element;
            idx = swap;
        }
    }
}

var minCost = function(maxTime, edges, passingFees) {
    const n = passingFees.length;
    const minCosts = Array(n).fill(0).map(() => Array(maxTime + 1).fill(Infinity));

    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v, travelTime, travelCost] of edges) {
        adj[u].push([v, travelTime, travelCost]);
        adj[v].push([u, travelTime, travelCost]);
    }

    const pq = new MinHeap();

    minCosts[0][0] = passingFees[0];
    pq.push([passingFees[0], 0, 0]); // [cost, time, city]

    while (!pq.isEmpty()) {
        const [currentCost, currentTime, currentCity] = pq.pop();

        if (currentCost > minCosts[currentCity][currentTime]) {
            continue;
        }

        for (const [neighborCity, travelTime, travelCost] of adj[currentCity]) {
            const newTime = currentTime + travelTime;
            const newCost = currentCost + travelCost + passingFees[neighborCity];

            if (newTime <= maxTime) {
                if (newCost < minCosts[neighborCity][newTime]) {
                    minCosts[neighborCity][newTime] = newCost;
                    pq.push([newCost, newTime, neighborCity]);
                }
            }
        }
    }

    let result = Infinity;
    for (let t = 0; t <= maxTime; t++) {
        result = Math.min(result, minCosts[n - 1][t]);
    }

    return result === Infinity ? -1 : result;
};