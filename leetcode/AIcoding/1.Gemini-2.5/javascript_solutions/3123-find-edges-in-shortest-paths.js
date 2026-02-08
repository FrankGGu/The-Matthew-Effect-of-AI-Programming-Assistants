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
        this._bubbleDown();
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

    _bubbleDown() {
        let index = 0;
        const length = this.heap.length;
        const element = this.heap[0];

        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let swap = null;

            if (leftChildIndex < length) {
                if (this.heap[leftChildIndex][0] < element[0]) {
                    swap = leftChildIndex;
                }
            }

            if (rightChildIndex < length) {
                if ((swap === null && this.heap[rightChildIndex][0] < element[0]) ||
                    (swap !== null && this.heap[rightChildIndex][0] < this.heap[leftChildIndex][0])) {
                    swap = rightChildIndex;
                }
            }

            if (swap === null) break;

            [this.heap[index], this.heap[swap]] = [this.heap[swap], this.heap[index]];
            index = swap;
        }
    }
}

function findShortestPaths(n, edges) {
    const graph = Array(n).fill(0).map(() => []);
    for (let i = 0; i < edges.length; i++) {
        const [u, v, w] = edges[i];
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    const dijkstra = (startNode) => {
        const dist = Array(n).fill(Infinity);
        dist[startNode] = 0;
        const pq = new MinHeap();
        pq.push([0, startNode]);

        while (!pq.isEmpty()) {
            const [d, u] = pq.pop();

            if (d > dist[u]) {
                continue;
            }

            for (const [v, weight] of graph[u]) {
                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.push([dist[v], v]);
                }
            }
        }
        return dist;
    };

    const dist0 = dijkstra(0);
    const distN = dijkstra(n - 1);

    const shortestPathLength = dist0[n - 1];
    const result = [];

    for (let i = 0; i < edges.length; i++) {
        const [u, v, w] = edges[i];
        if (dist0[u] + w + distN[v] === shortestPathLength) {
            result.push(i);
        } else if (dist0[v] + w + distN[u] === shortestPathLength) {
            result.push(i);
        }
    }

    return result;
}