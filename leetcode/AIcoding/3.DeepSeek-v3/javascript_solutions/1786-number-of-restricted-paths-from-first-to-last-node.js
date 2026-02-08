const countRestrictedPaths = function(n, edges) {
    const MOD = 1e9 + 7;
    const graph = new Array(n + 1).fill().map(() => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    const dist = new Array(n + 1).fill(Infinity);
    dist[n] = 0;
    const heap = new MinHeap();
    heap.insert([n, 0]);

    while (!heap.isEmpty()) {
        const [u, currentDist] = heap.extractMin();
        if (currentDist > dist[u]) continue;
        for (const [v, w] of graph[u]) {
            if (dist[v] > dist[u] + w) {
                dist[v] = dist[u] + w;
                heap.insert([v, dist[v]]);
            }
        }
    }

    const memo = new Array(n + 1).fill(-1);
    const dfs = (u) => {
        if (u === n) return 1;
        if (memo[u] !== -1) return memo[u];
        let res = 0;
        for (const [v, _] of graph[u]) {
            if (dist[v] < dist[u]) {
                res = (res + dfs(v)) % MOD;
            }
        }
        memo[u] = res;
        return res;
    };

    return dfs(1);
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    insert(val) {
        this.heap.push(val);
        this.bubbleUp();
    }

    extractMin() {
        const min = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.bubbleDown();
        }
        return min;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp() {
        let idx = this.heap.length - 1;
        const element = this.heap[idx];
        while (idx > 0) {
            let parentIdx = Math.floor((idx - 1) / 2);
            let parent = this.heap[parentIdx];
            if (element[1] >= parent[1]) break;
            this.heap[idx] = parent;
            idx = parentIdx;
        }
        this.heap[idx] = element;
    }

    bubbleDown() {
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
                if (leftChild[1] < element[1]) {
                    swap = leftChildIdx;
                }
            }

            if (rightChildIdx < length) {
                rightChild = this.heap[rightChildIdx];
                if (
                    (swap === null && rightChild[1] < element[1]) ||
                    (swap !== null && rightChild[1] < leftChild[1])
                ) {
                    swap = rightChildIdx;
                }
            }

            if (swap === null) break;
            this.heap[idx] = this.heap[swap];
            idx = swap;
        }
        this.heap[idx] = element;
    }
}