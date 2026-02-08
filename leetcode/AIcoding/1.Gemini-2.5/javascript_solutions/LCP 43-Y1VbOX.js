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
        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._sinkDown(0);
        return min;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp(idx) {
        const element = this.heap[idx];
        while (idx > 0) {
            let parentIdx = Math.floor((idx - 1) / 2);
            let parent = this.heap[parentIdx];
            if (element[0] >= parent[0]) {
                break;
            }
            this.heap[parentIdx] = element;
            this.heap[idx] = parent;
            idx = parentIdx;
        }
    }

    _sinkDown(idx) {
        const length = this.heap.length;
        const element = this.heap[idx];
        while (true) {
            let leftChildIdx = 2 * idx + 1;
            let rightChildIdx = 2 * idx + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIdx < length) {
                leftChild = this.heap[leftChildIdx];
                if (leftChild[0] < element[0]) {
                    swap = leftChildIdx;
                }
            }
            if (rightChildIdx < length) {
                rightChild = this.heap[rightChildIdx];
                if (
                    (swap === null && rightChild[0] < element[0]) ||
                    (swap !== null && rightChild[0] < leftChild[0])
                ) {
                    swap = rightChildIdx;
                }
            }

            if (swap === null) {
                break;
            }
            this.heap[idx] = this.heap[swap];
            this.heap[swap] = element;
            idx = swap;
        }
    }
}

var minimumTime = function(traffic) {
    const m = traffic.length;
    const n = traffic[0].length;

    const dist = Array(m).fill(0).map(() => Array(n).fill(Infinity));
    dist[0][0] = 0;

    const pq = new MinHeap();
    pq.push([0, 0, 0]);

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (!pq.isEmpty()) {
        const [currentTime, r, c] = pq.pop();

        if (currentTime > dist[r][c]) {
            continue;
        }

        if (r === m - 1 && c === n - 1) {
            return currentTime;
        }

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                let nextTime = currentTime + 1;

                if (traffic[nr][nc] > 0) {
                    const cycle = traffic[nr][nc];
                    const fullCycle = 2 * cycle;
                    const remainder = nextTime % fullCycle;

                    if (dr === 0) {
                        if (remainder >= cycle) {
                            const wait = fullCycle - remainder;
                            nextTime += wait;
                        }
                    } else {
                        if (remainder < cycle) {
                            const wait = cycle - remainder;
                            nextTime += wait;
                        }
                    }
                }

                if (nextTime < dist[nr][nc]) {
                    dist[nr][nc] = nextTime;
                    pq.push([nextTime, nr, nc]);
                }
            }
        }
    }

    return -1;
};