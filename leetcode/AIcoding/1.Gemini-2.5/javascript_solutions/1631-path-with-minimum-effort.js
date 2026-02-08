class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(element) {
        this.heap.push(element);
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

var minimumEffortPath = function(heights) {
    const rows = heights.length;
    const cols = heights[0].length;

    const minEffort = Array(rows).fill(0).map(() => Array(cols).fill(Infinity));
    minEffort[0][0] = 0;

    const pq = new MinHeap();
    pq.push([0, 0, 0]); // [effort, row, col]

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    while (!pq.isEmpty()) {
        const [currentEffort, r, c] = pq.pop();

        if (r === rows - 1 && c === cols - 1) {
            return currentEffort;
        }

        if (currentEffort > minEffort[r][c]) {
            continue;
        }

        for (let i = 0; i < 4; i++) {
            const nr = r + dr[i];
            const nc = c + dc[i];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                const diff = Math.abs(heights[r][c] - heights[nr][nc]);
                const newEffort = Math.max(currentEffort, diff);

                if (newEffort < minEffort[nr][nc]) {
                    minEffort[nr][nc] = newEffort;
                    pq.push([newEffort, nr, nc]);
                }
            }
        }
    }

    return -1; // Should not be reached if a path always exists
};