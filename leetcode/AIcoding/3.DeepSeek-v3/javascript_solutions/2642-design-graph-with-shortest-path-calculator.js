class Graph {
    constructor(n, edges) {
        this.n = n;
        this.adj = new Array(n).fill().map(() => []);
        for (const [u, v, cost] of edges) {
            this.adj[u].push([v, cost]);
        }
    }

    addEdge(edge) {
        const [u, v, cost] = edge;
        this.adj[u].push([v, cost]);
    }

    shortestPath(node1, node2) {
        const dist = new Array(this.n).fill(Infinity);
        dist[node1] = 0;
        const heap = new MinHeap();
        heap.insert([node1, 0]);

        while (!heap.isEmpty()) {
            const [u, currentDist] = heap.extractMin();
            if (u === node2) {
                return currentDist;
            }
            if (currentDist > dist[u]) {
                continue;
            }
            for (const [v, cost] of this.adj[u]) {
                if (dist[v] > dist[u] + cost) {
                    dist[v] = dist[u] + cost;
                    heap.insert([v, dist[v]]);
                }
            }
        }

        return -1;
    }
}

class MinHeap {
    constructor() {
        this.heap = [];
    }

    insert(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    extractMin() {
        const min = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.bubbleDown(0);
        }
        return min;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp(index) {
        const element = this.heap[index];
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            const parent = this.heap[parentIndex];
            if (element[1] >= parent[1]) break;
            this.heap[index] = parent;
            this.heap[parentIndex] = element;
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const element = this.heap[index];
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIndex < length) {
                leftChild = this.heap[leftChildIndex];
                if (leftChild[1] < element[1]) {
                    swap = leftChildIndex;
                }
            }

            if (rightChildIndex < length) {
                rightChild = this.heap[rightChildIndex];
                if (
                    (swap === null && rightChild[1] < element[1]) ||
                    (swap !== null && rightChild[1] < leftChild[1])
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