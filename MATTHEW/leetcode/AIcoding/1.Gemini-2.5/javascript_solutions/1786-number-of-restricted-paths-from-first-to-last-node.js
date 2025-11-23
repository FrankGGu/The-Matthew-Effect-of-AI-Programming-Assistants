class MinHeap {
    constructor() {
        this.heap = [];
    }

    getParentIndex(i) {
        return Math.floor((i - 1) / 2);
    }

    getLeftChildIndex(i) {
        return 2 * i + 1;
    }

    getRightChildIndex(i) {
        return 2 * i + 2;
    }

    hasParent(i) {
        return this.getParentIndex(i) >= 0;
    }

    hasLeftChild(i) {
        return this.getLeftChildIndex(i) < this.heap.length;
    }

    hasRightChild(i) {
        return this.getRightChildIndex(i) < this.heap.length;
    }

    getParent(i) {
        return this.heap[this.getParentIndex(i)];
    }

    getLeftChild(i) {
        return this.heap[this.getLeftChildIndex(i)];
    }

    getRightChild(i) {
        return this.heap[this.getRightChildIndex(i)];
    }

    swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    peek() {
        if (this.heap.length === 0) {
            return null;
        }
        return this.heap[0];
    }

    push(item) {
        this.heap.push(item);
        this.heapifyUp();
    }

    pop() {
        if (this.heap.length === 0) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.heapifyDown();
        return item;
    }

    heapifyUp() {
        let index = this.heap.length - 1;
        while (this.hasParent(index) && this.getParent(index)[0] > this.heap[index][0]) {
            this.swap(this.getParentIndex(index), index);
            index = this.getParentIndex(index);
        }
    }

    heapifyDown() {
        let index = 0;
        while (this.hasLeftChild(index)) {
            let smallerChildIndex = this.getLeftChildIndex(index);
            if (this.hasRightChild(index) && this.getRightChild(index)[0] < this.getLeftChild(index)[0]) {
                smallerChildIndex = this.getRightChildIndex(index);
            }

            if (this.heap[index][0] < this.heap[smallerChildIndex][0]) {
                break;
            } else {
                this.swap(index, smallerChildIndex);
            }
            index = smallerChildIndex;
        }
    }

    isEmpty() {
        return this.heap.length === 0;
    }
}

var countRestrictedPaths = function(n, edges) {
    const MOD = 10**9 + 7;

    const adj = Array(n + 1).fill(0).map(() => []);
    for (const [u, v, w] of edges) {
        adj[u].push([v, w]);
        adj[v].push([u, w]);
    }

    const dist = Array(n + 1).fill(Infinity);
    const pq = new MinHeap();

    dist[n] = 0;
    pq.push([0, n]);

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

    const memo = Array(n + 1).fill(-1);

    const dfs = (u) => {
        if (u === n) {
            return 1;
        }
        if (memo[u] !== -1) {
            return memo[u];
        }

        let count = 0;
        for (const [v, weight] of adj[u]) {
            if (dist[u] > dist[v]) {
                count = (count + dfs(v)) % MOD;
            }
        }
        memo[u] = count;
        return count;
    };

    return dfs(1);
};