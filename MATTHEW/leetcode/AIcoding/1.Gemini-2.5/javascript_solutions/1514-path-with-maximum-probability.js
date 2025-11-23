class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return root;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex][0] > this.heap[index][0]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _bubbleDown(index) {
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

            if (smallestIndex !== index) {
                [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
                index = smallestIndex;
            } else {
                break;
            }
        }
    }
}

var maxProbability = function(n, edges, succProb, start, end) {
    const adj = new Array(n).fill(0).map(() => []);

    for (let i = 0; i < edges.length; i++) {
        const [u, v] = edges[i];
        const prob = succProb[i];
        adj[u].push([v, prob]);
        adj[v].push([u, prob]);
    }

    const maxProb = new Array(n).fill(0.0);
    maxProb[start] = 1.0;

    const pq = new MinHeap();
    pq.push([-1.0, start]);

    while (!pq.isEmpty()) {
        const [currentNegProb, u] = pq.pop();
        const currentProb = -currentNegProb;

        if (currentProb < maxProb[u]) {
            continue;
        }

        for (const [v, pathProb] of adj[u]) {
            if (maxProb[u] * pathProb > maxProb[v]) {
                maxProb[v] = maxProb[u] * pathProb;
                pq.push([-maxProb[v], v]);
            }
        }
    }

    return maxProb[end];
};