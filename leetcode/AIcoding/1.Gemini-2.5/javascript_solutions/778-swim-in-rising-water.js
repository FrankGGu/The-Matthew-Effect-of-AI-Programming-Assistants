class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return min;
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
            const leftChildIndex = 2 * index + 1;
            const rightChildIndex = 2 * index + 2;
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

var swimInRisingWater = function(grid) {
    const n = grid.length;
    const dist = Array(n).fill(0).map(() => Array(n).fill(Infinity));
    const pq = new MinHeap();

    dist[0][0] = grid[0][0];
    pq.push([grid[0][0], 0, 0]); // [max_elevation_reached_so_far, row, col]

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (!pq.isEmpty()) {
        const [currentTime, r, c] = pq.pop();

        if (currentTime > dist[r][c]) {
            continue;
        }

        if (r === n - 1 && c === n - 1) {
            return currentTime;
        }

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                const newTime = Math.max(currentTime, grid[nr][nc]);
                if (newTime < dist[nr][nc]) {
                    dist[nr][nc] = newTime;
                    pq.push([newTime, nr, nc]);
                }
            }
        }
    }

    return -1;
};