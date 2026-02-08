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
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._sinkDown();
        return min;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex][0] > this.heap[index][0]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _sinkDown() {
        let index = 0;
        const length = this.heap.length;
        const element = this.heap[0];

        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIndex < length) {
                leftChild = this.heap[leftChildIndex];
                if (leftChild[0] < element[0]) {
                    swap = leftChildIndex;
                }
            }

            if (rightChildIndex < length) {
                rightChild = this.heap[rightChildIndex];
                if (
                    (swap === null && rightChild[0] < element[0]) ||
                    (swap !== null && rightChild[0] < leftChild[0])
                ) {
                    swap = rightChildIndex;
                }
            }

            if (swap === null) {
                break;
            }
            [this.heap[index], this.heap[swap]] = [this.heap[swap], this.heap[index]];
            index = swap;
        }
    }
}

var countPaths = function(n, roads) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v, time] of roads) {
        adj[u].push([v, time]);
        adj[v].push([u, time]);
    }

    const dist = new Array(n).fill(Infinity);
    const ways = new Array(n).fill(0);
    const MOD = 1e9 + 7;

    dist[0] = 0;
    ways[0] = 1;

    const pq = new MinHeap();
    pq.push([0, 0]);

    while (!pq.isEmpty()) {
        const [d, u] = pq.pop();

        if (d > dist[u]) {
            continue;
        }

        for (const [v, time] of adj[u]) {
            const new_dist = d + time;

            if (new_dist < dist[v]) {
                dist[v] = new_dist;
                ways[v] = ways[u];
                pq.push([new_dist, v]);
            } else if (new_dist === dist[v]) {
                ways[v] = (ways[v] + ways[u]) % MOD;
            }
        }
    }

    return ways[n - 1];
};