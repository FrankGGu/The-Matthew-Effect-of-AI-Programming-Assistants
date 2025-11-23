var reachableNodes = function(n, edges, maxMoves) {
    // Min-Priority Queue implementation
    class MinPriorityQueue {
        constructor() {
            this.heap = [];
        }

        push(item) {
            this.heap.push(item);
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

        isEmpty() {
            return this.heap.length === 0;
        }

        _bubbleUp() {
            let index = this.heap.length - 1;
            while (index > 0) {
                let parentIndex = Math.floor((index - 1) / 2);
                if (this.heap[parentIndex][0] <= this.heap[index][0]) {
                    break;
                }
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            }
        }

        _bubbleDown() {
            let index = 0;
            const lastIndex = this.heap.length - 1;
            while (true) {
                let leftChildIndex = 2 * index + 1;
                let rightChildIndex = 2 * index + 2;
                let smallestIndex = index;

                if (leftChildIndex <= lastIndex && this.heap[leftChildIndex][0] < this.heap[smallestIndex][0]) {
                    smallestIndex = leftChildIndex;
                }

                if (rightChildIndex <= lastIndex && this.heap[rightChildIndex][0] < this.heap[smallestIndex][0]) {
                    smallestIndex = rightChildIndex;
                }

                if (smallestIndex === index) {
                    break;
                }

                [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
                index = smallestIndex;
            }
        }
    }

    const adj = new Array(n).fill(0).map(() => []);

    for (const [u, v, numSubdivisions] of edges) {
        adj[u].push([v, numSubdivisions + 1]);
        adj[v].push([u, numSubdivisions + 1]);
    }

    const dist = new Array(n).fill(Infinity);
    dist[0] = 0;
    const pq = new MinPriorityQueue();
    pq.push([0, 0]);

    while (!pq.isEmpty()) {
        const [d, u] = pq.pop();

        if (d > dist[u]) {
            continue;
        }

        for (const [v, weight] of adj[u]) {
            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                pq.push([dist[v], v]);
            }
        }
    }

    let reachableCount = 0;

    for (let i = 0; i < n; i++) {
        if (dist[i] <= maxMoves) {
            reachableCount++;
        }
    }

    for (const [u, v, numSubdivisions] of edges) {
        const movesFromU = Math.max(0, maxMoves - dist[u]);
        const movesFromV = Math.max(0, maxMoves - dist[v]);

        const reachableFromUSide = Math.min(numSubdivisions, movesFromU);
        const reachableFromVSide = Math.min(numSubdivisions, movesFromV);

        reachableCount += Math.min(numSubdivisions, reachableFromUSide + reachableFromVSide);
    }

    return reachableCount;
};