class Graph {
    constructor(n) {
        this.graph = new Map();
        this.n = n;
    }

    addEdge(u, v, w) {
        if (!this.graph.has(u)) this.graph.set(u, []);
        if (!this.graph.has(v)) this.graph.set(v, []);
        this.graph.get(u).push({ node: v, weight: w });
        this.graph.get(v).push({ node: u, weight: w });
    }

    shortestPath(source, target) {
        const dist = new Array(this.n).fill(Infinity);
        dist[source] = 0;
        const pq = new MinPriorityQueue();
        pq.enqueue(source, 0);

        while (!pq.isEmpty()) {
            const { element: u } = pq.dequeue();
            if (u === target) return dist[u];

            for (const { node: v, weight } of (this.graph.get(u) || [])) {
                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.enqueue(v, dist[v]);
                }
            }
        }

        return -1;
    }
}

class MinPriorityQueue {
    constructor() {
        this.heap = [];
    }

    enqueue(element, priority) {
        this.heap.push({ element, priority });
        this.bubbleUp();
    }

    dequeue() {
        const min = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.sinkDown();
        }
        return min;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        const element = this.heap[index];

        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            let parent = this.heap[parentIndex];

            if (element.priority >= parent.priority) break;

            this.heap[parentIndex] = element;
            this.heap[index] = parent;
            index = parentIndex;
        }
    }

    sinkDown() {
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
                if (leftChild.priority < element.priority) {
                    swap = leftChildIndex;
                }
            }

            if (rightChildIndex < length) {
                rightChild = this.heap[rightChildIndex];
                if (
                    (swap === null && rightChild.priority < element.priority) ||
                    (swap !== null && rightChild.priority < leftChild.priority)
                ) {
                    swap = rightChildIndex;
                }
            }

            if (swap === null) break;

            this.heap[index] = this.heap[swap];
            this.heap[swap] = element;
            index = swap;
        }
    }
}