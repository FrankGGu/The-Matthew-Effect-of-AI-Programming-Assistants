class MinPriorityQueue {
    constructor() {
        this.heap = [];
    }

    getParentIndex(i) { return Math.floor((i - 1) / 2); }
    getLeftChildIndex(i) { return 2 * i + 1; }
    getRightChildIndex(i) { return 2 * i + 2; }

    hasParent(i) { return this.getParentIndex(i) >= 0; }
    hasLeftChild(i) { return this.getLeftChildIndex(i) < this.heap.length; }
    hasRightChild(i) { return this.getRightChildIndex(i) < this.heap.length; }

    getParent(i) { return this.heap[this.getParentIndex(i)]; }
    getLeftChild(i) { return this.heap[this.getLeftChildIndex(i)]; }
    getRightChild(i) { return this.heap[this.getRightChildIndex(i)]; }

    isEmpty() {
        return this.heap.length === 0;
    }

    insert(item) {
        this.heap.push(item);
        this.heapifyUp();
    }

    extractMin() {
        if (this.heap.length === 0) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.heapifyDown();
        return item;
    }

    heapifyUp() {
        let index = this.heap.length - 1;
        while (this.hasParent(index) && this.getParent(index).cost > this.heap[index].cost) {
            [this.heap[this.getParentIndex(index)], this.heap[index]] = [this.heap[index], this.heap[this.getParentIndex(index)]];
            index = this.getParentIndex(index);
        }
    }

    heapifyDown() {
        let index = 0;
        while (this.hasLeftChild(index)) {
            let smallerChildIndex = this.getLeftChildIndex(index);
            if (this.hasRightChild(index) && this.getRightChild(index).cost < this.getLeftChild(index).cost) {
                smallerChildIndex = this.getRightChildIndex(index);
            }

            if (this.heap[index].cost < this.heap[smallerChildIndex].cost) {
                break;
            } else {
                [this.heap[index], this.heap[smallerChildIndex]] = [this.heap[smallerChildIndex], this.heap[index]];
            }
            index = smallerChildIndex;
        }
    }
}

function minimumCost(source, target, original, changed, cost) {
    const stringToIdMap = new Map();
    let nextId = 0;

    let maxLen = 0;
    for (let i = 0; i < original.length; i++) {
        if (!stringToIdMap.has(original[i])) {
            stringToIdMap.set(original[i], nextId++);
        }
        if (!stringToIdMap.has(changed[i])) {
            stringToIdMap.set(changed[i], nextId++);
        }
        maxLen = Math.max(maxLen, original[i].length);
    }

    const numStrings = nextId;
    const adj = Array(numStrings).fill(0).map(() => []);

    for (let i = 0; i < original.length; i++) {
        const u = stringToIdMap.get(original[i]);
        const v = stringToIdMap.get(changed[i]);
        const c = cost[i];
        adj[u].push({ to: v, weight: c });
    }

    const dist = Array(numStrings).fill(0).map(() => Array(numStrings).fill(Infinity));

    for (let startNodeId = 0; startNodeId < numStrings; startNodeId++) {
        const pq = new MinPriorityQueue();
        pq.insert({ node: startNodeId, cost: 0 });
        dist[startNodeId][startNodeId] = 0;

        while (!pq.isEmpty()) {
            const { node: u, cost: d } = pq.extractMin();

            if (d > dist[startNodeId][u]) {
                continue;
            }

            for (const edge of adj[u]) {
                const v = edge.to;
                const weight = edge.weight;
                if (dist[startNodeId][u] + weight < dist[startNodeId][v]) {
                    dist[startNodeId][v] = dist[startNodeId][u] + weight;
                    pq.insert({ node: v, cost: dist[startNodeId][v] });
                }
            }
        }
    }

    const n = source.length;
    const dp = Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        if (source[i - 1] === target[i - 1]) {
            dp[i] = Math.min(dp[i], dp[i - 1]);
        }

        for (let len = 1; len <= maxLen; len++) {
            const j = i - len;
            if (j < 0) continue;

            const subSource = source.substring(j, i);
            const subTarget = target.substring(j, i);

            if (stringToIdMap.has(subSource) && stringToIdMap.has(subTarget)) {
                const idSource = stringToIdMap.get(subSource);
                const idTarget = stringToIdMap.get(subTarget);

                if (dist[idSource][idTarget] !== Infinity) {
                    dp[i] = Math.min(dp[i], dp[j] + dist[idSource][idTarget]);
                }
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
}