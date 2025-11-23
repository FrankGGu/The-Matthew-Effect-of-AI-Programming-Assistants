class MinHeap {
    constructor() {
        this.heap = [];
    }

    insert(node) {
        this.heap.push(node);
        this.bubbleUp();
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[index][1] >= this.heap[parentIndex][1]) break;
            [this.heap[index], this.heap[parentIndex]] = [this.heap[parentIndex], this.heap[index]];
            index = parentIndex;
        }
    }

    extractMin() {
        if (this.heap.length === 0) return null;
        if (this.heap.length === 1) return this.heap.pop();
        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.bubbleDown();
        return min;
    }

    bubbleDown() {
        let index = 0;
        const length = this.heap.length;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex < length && this.heap[leftChildIndex][1] < this.heap[smallestIndex][1]) {
                smallestIndex = leftChildIndex;
            }
            if (rightChildIndex < length && this.heap[rightChildIndex][1] < this.heap[smallestIndex][1]) {
                smallestIndex = rightChildIndex;
            }
            if (smallestIndex === index) break;
            [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
            index = smallestIndex;
        }
    }

    isEmpty() {
        return this.heap.length === 0;
    }
}

var minimumWeight = function(n, edges, src1, src2, dest) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v, weight] of edges) {
        graph[u].push([v, weight]);
        graph[v].push([u, weight]);
    }

    const dijkstra = (start) => {
        const dist = Array(n).fill(Infinity);
        const minHeap = new MinHeap();
        dist[start] = 0;
        minHeap.insert([start, 0]);

        while (!minHeap.isEmpty()) {
            const [node, weight] = minHeap.extractMin();
            if (weight > dist[node]) continue;

            for (const [neighbor, edgeWeight] of graph[node]) {
                const newWeight = weight + edgeWeight;
                if (newWeight < dist[neighbor]) {
                    dist[neighbor] = newWeight;
                    minHeap.insert([neighbor, newWeight]);
                }
            }
        }
        return dist;
    };

    const distFromSrc1 = dijkstra(src1);
    const distFromSrc2 = dijkstra(src2);
    const distFromDest = dijkstra(dest);

    let minWeight = Infinity;
    for (let i = 0; i < n; i++) {
        if (distFromSrc1[i] !== Infinity && distFromSrc2[i] !== Infinity && distFromDest[i] !== Infinity) {
            minWeight = Math.min(minWeight, distFromSrc1[i] + distFromSrc2[i] + distFromDest[i]);
        }
    }

    return minWeight === Infinity ? -1 : minWeight;
};