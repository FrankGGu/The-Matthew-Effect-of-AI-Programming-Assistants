const countPaths = function(n, roads) {
    const MOD = 1e9 + 7;
    const graph = new Array(n).fill().map(() => []);
    for (const [u, v, time] of roads) {
        graph[u].push([v, time]);
        graph[v].push([u, time]);
    }

    const dist = new Array(n).fill(Infinity);
    const ways = new Array(n).fill(0);
    const minHeap = new PriorityQueue((a, b) => a[1] < b[1]);

    dist[0] = 0;
    ways[0] = 1;
    minHeap.enqueue([0, 0]);

    while (!minHeap.isEmpty()) {
        const [u, currentDist] = minHeap.dequeue();
        if (currentDist > dist[u]) continue;

        for (const [v, time] of graph[u]) {
            if (dist[v] > dist[u] + time) {
                dist[v] = dist[u] + time;
                ways[v] = ways[u];
                minHeap.enqueue([v, dist[v]]);
            } else if (dist[v] === dist[u] + time) {
                ways[v] = (ways[v] + ways[u]) % MOD;
            }
        }
    }

    return ways[n - 1];
};

class PriorityQueue {
    constructor(comparator = (a, b) => a > b) {
        this.heap = [];
        this.comparator = comparator;
    }

    enqueue(value) {
        this.heap.push(value);
        this.bubbleUp();
    }

    dequeue() {
        const top = this.heap[0];
        const bottom = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = bottom;
            this.bubbleDown();
        }
        return top;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            const parent = Math.floor((index - 1) / 2);
            if (this.comparator(this.heap[index], this.heap[parent])) {
                [this.heap[index], this.heap[parent]] = [this.heap[parent], this.heap[index]];
                index = parent;
            } else {
                break;
            }
        }
    }

    bubbleDown() {
        let index = 0;
        const length = this.heap.length;
        while (true) {
            const left = 2 * index + 1;
            const right = 2 * index + 2;
            let swap = null;

            if (left < length && this.comparator(this.heap[left], this.heap[index])) {
                swap = left;
            }
            if (right < length && this.comparator(this.heap[right], (swap === null ? this.heap[index] : this.heap[left]))) {
                swap = right;
            }

            if (swap === null) break;
            [this.heap[index], this.heap[swap]] = [this.heap[swap], this.heap[index]];
            index = swap;
        }
    }
}