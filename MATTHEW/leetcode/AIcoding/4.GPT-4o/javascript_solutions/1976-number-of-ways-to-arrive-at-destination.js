var countPaths = function(n, roads) {
    const mod = 1e9 + 7;
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v, time] of roads) {
        graph[u].push([v, time]);
        graph[v].push([u, time]);
    }

    const dist = Array(n).fill(Infinity);
    const ways = Array(n).fill(0);
    dist[0] = 0;
    ways[0] = 1;

    const pq = new PriorityQueue((a, b) => a[0] - b[0]);
    pq.push([0, 0]);

    while (!pq.isEmpty()) {
        const [d, node] = pq.pop();
        if (d > dist[node]) continue;

        for (const [neighbor, time] of graph[node]) {
            const newDist = d + time;
            if (newDist < dist[neighbor]) {
                dist[neighbor] = newDist;
                ways[neighbor] = ways[node];
                pq.push([newDist, neighbor]);
            } else if (newDist === dist[neighbor]) {
                ways[neighbor] = (ways[neighbor] + ways[node]) % mod;
            }
        }
    }

    return ways[n - 1];
};

class PriorityQueue {
    constructor(compare) {
        this.heap = [];
        this.compare = compare;
    }

    push(value) {
        this.heap.push(value);
        this.bubbleUp();
    }

    pop() {
        const top = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.sinkDown();
        }
        return top;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        const element = this.heap[index];
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            const parent = this.heap[parentIndex];
            if (this.compare(element, parent) >= 0) break;
            this.heap[index] = parent;
            index = parentIndex;
        }
        this.heap[index] = element;
    }

    sinkDown() {
        let index = 0;
        const length = this.heap.length;
        const element = this.heap[0];
        while (true) {
            const leftChildIndex = 2 * index + 1;
            const rightChildIndex = 2 * index + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIndex < length) {
                leftChild = this.heap[leftChildIndex];
                if (this.compare(leftChild, element) < 0) {
                    swap = leftChildIndex;
                }
            }

            if (rightChildIndex < length) {
                rightChild = this.heap[rightChildIndex];
                if ((swap === null && this.compare(rightChild, element) < 0) || 
                    (swap !== null && this.compare(rightChild, leftChild) < 0)) {
                    swap = rightChildIndex;
                }
            }

            if (swap === null) break;
            this.heap[index] = this.heap[swap];
            index = swap;
        }
        this.heap[index] = element;
    }
}