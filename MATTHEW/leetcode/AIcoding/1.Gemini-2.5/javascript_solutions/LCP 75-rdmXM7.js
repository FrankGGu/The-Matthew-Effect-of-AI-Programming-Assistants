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
        const min = this.heap[0];
        const last = this.heap.pop();
        if (!this.isEmpty()) {
            this.heap[0] = last;
            this._sinkDown();
        }
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

    _sinkDown() {
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
                if (leftChild[0] < element[0]) {
                    swap = leftChildIndex;
                }
            }

            if (rightChildIndex < length) {
                rightChild = this.heap[rightChildIndex];
                if (
                    (swap === null && rightChild[0] < element[0]) ||
                    (swap !== null && rightChild[0] < leftChild[0])
                ) {
                    swap = rightChildIndex;
                }
            }

            if (swap === null) {
                break;
            }
            [this.heap[index], this.heap[swap]] = [this.heap[swap], this.heap[index]];
            index = swap;
        }
    }
}

var solveTeleportScrolls = function(m, n, start, end, teleports) {
    const numCells = m * n;
    const dist = new Array(numCells).fill(Infinity);
    const pq = new MinPriorityQueue();

    const startIdx = start[0] * n + start[1];
    const endIdx = end[0] * n + end[1];

    dist[startIdx] = 0;
    pq.push([0, startIdx]);

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    const teleportMap = new Map();
    for (const [r1, c1, r2, c2, cost] of teleports) {
        const sourceIdx = r1 * n + c1;
        const targetIdx = r2 * n + c2;
        if (!teleportMap.has(sourceIdx)) {
            teleportMap.set(sourceIdx, []);
        }
        teleportMap.get(sourceIdx).push([targetIdx, cost]);
    }

    while (!pq.isEmpty()) {
        const [currentCost, currentIdx] = pq.pop();

        if (currentCost > dist[currentIdx]) {
            continue;
        }

        if (currentIdx === endIdx) {
            return currentCost;
        }

        const r = Math.floor(currentIdx / n);
        const c = currentIdx % n;

        for (let i = 0; i < 4; i++) {
            const nr = r + dr[i];
            const nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                const neighborIdx = nr * n + nc;
                const newCost = currentCost + 1;
                if (newCost < dist[neighborIdx]) {
                    dist[neighborIdx] = newCost;
                    pq.push([newCost, neighborIdx]);
                }
            }
        }

        if (teleportMap.has(currentIdx)) {
            for (const [targetIdx, teleportCost] of teleportMap.get(currentIdx)) {
                const newCost = currentCost + teleportCost;
                if (newCost < dist[targetIdx]) {
                    dist[targetIdx] = newCost;
                    pq.push([newCost, targetIdx]);
                }
            }
        }
    }

    return -1;
};